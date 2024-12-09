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
  - In earlier editions of Windows, these are their own apps unless you have [manually installed Windows Terminal](https://learn.microsoft.com/en-gb/windows/terminal/install).
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
- Do not generate a new SSH key. Copy the key you generated for your windows PC from `C:\Users\<YOUR_USERNAME>\.ssh` into the WSL installation's `~/.ssh` (you should make this directory if it doesn't already exist)
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

# docker-image

Start by creating the following directory in git bash

```bash
mkdir ~/sites/academyServer
```

now cd into it

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
docker-compose up
```

This will take far longer than it did on your Mac, just wait... at some point it will stop.

You should now be able to load [http://localhost:1234](http://localhost:1234) in your browser and see a success page.

Provided you see the success page, now press ctrl+c on the running docker image. This will gracefully shut down your image.

To run your docker image in the background you can run:

```bash
docker-compose up --detach
```

This should boot your docker containers and run your image in the background.

Now that your docker containers are running in the background, you may want to set docker to start upon login. You can do this by ticking `Docker Preferences > General > Start Docker Desktop when you login`

You can now put all your application files in:

```
~/sites/academyServer/html
```

You should probably favourite this directory in your file explorer. To do that, navigate to `~/sites/academyServer/` in git bash and type `explorer .`, this will open the folder in windows file explorer. Now right click the `html` directory and click "Add to favourites".

You will also want to download all the programs in in prep course document (except sequal pro, as its Mac only, for that I suggest Table Plus). In addition you will want to install [composer](https://getcomposer.org/doc/00-intro.md#installation-windows).

#### Done. Everything from here on works as close to a Mac as we can get it

To shutdown your box run:

```bash
docker-compose down
```

Note: Your Box will turn itself on as soon as docker is started unless you have manually shut it down.

If your box has any problems, it will auto-restart itself, so sometimes it may slow down during this process. If this happens, logs will appear in:

```
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
docker-compose exec php php -a
```

To execute bash commands against your box, run the following:

```bash
docker-compose exec php bash
```

### Editing Docker Config

When changing the docker config files, you need to rebuild the containers using this command:

```bash
docker-compose up --force-recreate --build
```
