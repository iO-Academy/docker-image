# Windows set-up

To use this docker image on Windows follow the below steps:

1. Check your CPU has virtualisation enabled

- Open Task Manager (search task manager from the launch bar)
- Click more details or advanced settings in the bottom right
- Navigate to the Performance tab
- Ensure Virtualisation is set to Enabled in the bottom right
- If it is disabled, speak to a trainer

2. Enable WSL2

- Open Powershell or Windows Command Prompt from the start menu.
  - In Windows 11 this is done from the Windows Terminal app.
  - In earlier editions of Windows, these are their own apps unless you have [manually installed Windows Terminal (recommended)](https://learn.microsoft.com/en-gb/windows/terminal/install).
- Run the command `wsl --install`.
- This will install WSL2 and the Ubuntu distribution of Linux
- Once you get a prompt back, check that WSL works by running `wsl`. This should launch your linux instalation.
- You should be asked to set a password for WSL
- Done! You may be prompted to restart your PC.

[For troubleshooting, try the official instructions here.](https://learn.microsoft.com/en-us/windows/wsl/install)

3. Download & install Docker desktop for windows

- [Download from here](https://docs.docker.com/desktop/setup/install/windows-install/)
- This will take a while, go to step 4 while this is downloading / installing
- During the install it may ask you to update the WSL kernel, follow the instructions, use all the defaults

4. Download & install Git for Windows

- [Download from here](https://git-scm.com/downloads)
- You need this to be able to use Git in Windows
- Using the defaults is fine

4b. Set up your SSH key to github

- This step is optional but recommended. You will need to do it later anyway
- [Follow GitHub's guide, this time for windows instead of mac](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

- It is a good idea to then follow the guide *again*, for your WSL installation
- This time, follow the instructions for Linux, except:
- Do not generate a new SSH key. **Copy** the key you generated for your windows PC from `C:\Users\<YOUR_USERNAME>\.ssh` into the WSL installation's `~/.ssh` (you should make this directory if it doesn't already exist)
  - This is so that you don't need to add another key to your GitHub account - Windows and WSL are on the same PC, so there is no big security reason not to share the SSH key
- Then follow the linux instructions to [add the SSH key to the ssh-agent](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=linux#adding-your-ssh-key-to-the-ssh-agent)
- To ensure that this SSH key is always used for GitHub in WSL we must create an SSH config
  - In WSL, `touch ~/.ssh/config`
  - `nano ~/.ssh/config`
  - Paste in the following:

  ```txt
  Host github.com
    AddKeysToAgent yes
    IdentityFile ~/.ssh/<YOUR_SSH_PRIVATE_KEY_FILE>
  ```

5. You're ready to follow the steps below.

- Maybe restart your computer? Windows likes a good off and on before big tasks.

## docker-image

We're going to use your WSL installation for all of these steps, to avoid interoperability problems between Docker and Windows. **Do not launch Docker commands in windows powershell or cmd.**

Launch a terminal window for your WSL installation (named Ubuntu / whichever distribution you installed previously).

Start by creating the following directory in WSL:

```bash
mkdir ~/sites/academyServer
```

Now cd into it

```bash
cd ~/sites/academyServer
```

Now we need to clone this repo into that directory, run the following command from the academyServer directory

```bash
git clone git@github.com:iO-Academy/docker-image.git .
```

Before starting docker, delete the `.git` folder to remove the connection with Github:

```bash
rm -rf .git
```

You can now turn the image on by running:

```bash
docker compose up --detach
```

This will take a while, just wait... at some point it will stop.

This should boot your docker containers and run your image in the background.

You should now be able to load [http://localhost:1234](http://localhost:1234) in your browser and see a success page.

Now we need to replicate the install script we used on Mac. The script probably won't just work in WSL, so we will need to do the steps manually.

Run these file copy commands sequentially. While in the docker-image/academyServer folder:

```bash
cp ./build/scripts/student/composer.sh ~/composer.sh
cp ./build/scripts/student/php.sh ~/php.sh
cp ./build/scripts/student/phpunit.sh ~/phpunit.sh
cp ./build/scripts/student/stop.sh ~/stop.sh
```

Now add aliases to these files to your PATH. **This depends on if you are using bash (default for most distros) or zsh as your shell in WSL**

Add the following lines to your .bashrc or .zshrc depending on which shell you are using:

```bash
alias phpunit='~/phpunit.sh'
alias composer='~/composer.sh'
alias php='~/php.sh'
alias stop='~/stop.sh'
```

These aliases will redirect e.g. the `php` command to the Docker installation while you are inside the html folder, as long as it is running. They **will** conflict with php and composer installations made directly in your WSL. **There should be no reason you would need php or composer installed directly in your WSL** as long as the docker containers are running. If you **need** directly installed PHP then you should copy the scripts from the trainer folder instead of the student folder.

To 'export' your projects from WSL, you should either:

- Make repos to upload straight to GitHub
- Copy the projects from WSL to somewhere on the Windows filesystem

**You should not use folders from the Windows filesystem to work on your projects in WSL - it will be very slow and likely have other problems.**

VSCode and PHPStorm both have ways to 'remote in' to a local WSL to work within the WSL filesystem:

- [VSCode instructions](https://code.visualstudio.com/docs/remote/wsl)
- [More VSCode instructions](https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-vscode)
- [PHPStorm instructions](https://www.jetbrains.com/help/phpstorm/remote-development-a.html#run_in_wsl)

### Done. Everything from here on works as close to a Mac as we can get it

You can now put all your application files in WSL, at the path:

```bash
~/sites/academyServer/html
```

You will also want to download all the programs in in prep course document (except Sequel Ace, as its Mac only).

To shut down the docker image so that it won't automatically relaunch, run:

```bash
docker compose down
```

Note: Your Box will turn itself on as soon as docker is started unless you have manually shut it down.

If your box has any problems, it will auto-restart itself, so sometimes it may slow down during this process. If this happens, logs will appear in:

```bash
~/sites/academyServer/logs/
```

## MySQL DB connection

You can connect to your docker DB server using the below credentials:

Host: `127.0.0.1`

User: `root`

Password: `password`

Port: `3306`

## PDO connection

To connect from PHP to your docker container, use `db` as the host address.
All other details as above.

## PHPMyAdmin

To use PHPMyAdmin to adminster databases open [http://localhost:8081/](http://localhost:8081/) and use the same credentials as above to log in (although there is no need to enter a host)

## Mongo Connection

Connection string for compass:  
`mongodb://root:password@localhost:27017/?authSource=admin&readPreference=primary&appname=MongoDB%20Compass&ssl=false`

To connect to Mongo from Node:

```javascript
const url = 'mongodb://localhost:27017/{DBNAME}';
const db = await MongoClient.connect(url)
```

## Execute Commands

To execute arbitrary php against your box you can run the following command:

```bash
docker compose exec php php -a
```

To execute bash commands against your box, run the following:

```bash
docker compose exec php bash
```

### Editing Docker Config

When changing the docker config files, you need to rebuild the containers using this command:

```bash
docker compose up --force-recreate --build
```
