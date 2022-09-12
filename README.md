# iO Academy Docker image

***!!!  Note:*** **If you are using an M1 chip, use [the M1 branch of these instructions](https://github.com/iO-Academy/docker-image/tree/apple-m1).**  ***!!!***


Start by creating the following directory

```
~/sites/academyServer
```

Once created set the permissions for the sites directory:

```bash
chmod -R 777 ~/sites
```

( You may need to sudo this command: `sudo chmod -R 777 ~/sites` )

Now we need to clone this repo into that directory. Run the following command from within the academyServer directory:

```bash
git clone git@github.com:iO-Academy/docker-image.git .
```

Before starting docker, delete the `.git` folder to remove the connection with Github:

```bash
rm -rf .git
```

Now you should run the install script. This is not something you would ordinarily need to do when setting up a docker image. This is a tool we have created to make running programs installed inside of docker easier.

```bash
./install.sh
```

You can now turn the image on by running:

```bash
docker-compose up
```

This will take a minute or two to run, once done it should finish on something that looks like the below:

```
mongo_1     | Version: ...
```

You should now be able to load [http://localhost:1234](http://localhost:1234) in your browser and see a success page.

Provided you see the success page, now press ctrl+c on the running docker image. This will gracefully shut down your image.

To run your docker image in the background you can run:

```bash
docker-compose up --detach
```

This should boot 5 containers and run your image in the background.

Now that your docker containers are running in the background, you may want to set docker to start upon login. You can do this by ticking `Docker Settings (cog) > General > Start Docker Desktop when you login`

You can now put all your application files in:
```
~/sites/academyServer/html
```

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
