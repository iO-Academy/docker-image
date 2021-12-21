# Windows set-up

To run this docker image on Windows follow the below steps:

1. Check your CPU has virtualisation enabled
  - Open Task Manager (search task manager from the launch bar)
  - Click more details or advanced settings in the bottom right
  - Navigate to the Performance tab
  - Ensure Virtualisation is set to Enabled in the bottom right
  - If it is disabled, speak to a trainer

2. Enable WSL2
  - Open the windows CMD (type CMD into the search bar and click on cmd.exe)
  - Run the following command: `wsl --install`
  - Once finished, restart your computer

3. Download & install Docker decktop for windows
  - [Download from here](https://hub.docker.com/editions/community/docker-ce-desktop-windows)
  - This will take a while, go to step 4 while this is downloading / installing
  - During the install phase it may ask you to update a WSL kernal, follow the instructions, use all the defaults

4. Download gitbash
  - [Download from here](https://git-scm.com/downloads)
  - Once installed, use this as your terminal window
  - Windows CMD is awful, git bash is similar to mac terminal
  - No, it doesnt auto-complete with tab, sorry

4b. Set up your SSH key to github
  - This step is optional but recommended. You will need to do it later anyway
  - Follow the same guide you did in the academy, but for windows
  - [Guide here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

5. Your ready to follow the steps below.
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
