---
description: "Running Umbraco on docker locally using docker compose"
---

# Running Umbraco in Docker using Docker Compose

To aid in developing Umbraco with additional services, the templates can provide the requisite files to run Umbraco with a SQL Server database in Docker.
This setup is designed to be used for local development, and not for production.

## Prerequisites

Before you can run Umbraco in Docker, you need to have the following installed:
* Version 14.3.0 or higher of the Umbraco Templates
* Docker Desktop

## Installing

Installing Umbraco with the Docker file and Docker Compose file is a two-step process.

First, create a folder to hold your project and enter that folder.

```bash
mkdir MyDockerProject
cd MyDockerProject
```
Next create your Umbraco project using the Umbraco Templates, and remember to use the `--add-docker` flag to include the Docker files.
Conventionally this is named the same as the folder, but is not a requirement.

```bash
dotnet new umbraco -n MyDockerProject --add-docker
```

Now we need to add some additional files to make docker compose work. We can do this using the `umbraco-compose` template, passing the project name we specified earlier to the `-P` parameter:

```bash
dotnet new umbraco-compose -P "MyDockerProject"
```

The `-P` flag is required to specify the correct paths in the docker-compose file. The project is now ready to run with docker compose.

The final folder structure looks like this:

* MyDockerProject
  * MyDockerProject
    * Typical project files
    * DockerFile
    * .dockerignore
  * .env
  * Database
    * DockerFile
    * healthcheck.sh
    * setup.sql
    * startup.sh
  * docker-compose.yml

As you can see the project now includes docker files for both Umbraco itself and the SQL server database, as well as some additional scripts to launch and configure the database.

It also includes a .env file with the password for the database.

## Running

To run the project run the `docker compose up` command from the root of the project, same folder as `docker-compose.yml`.

This command will build both the Umbraco and Sql Server images and launch them in the correct order, after a while the site will have booted and you can navigate to it in your browser like nomral on `http://localhost:44372/`

### Useful commands

There is some useful commands you can use to manage the docker containers:

* `docker compose down --volumes` This will delete your containers and the volumes they use, this is useful if you want to start from scratch.

{% hint style="warning" %}
This delete your database and all data in it, so be careful with this command.
{% endhint %}

* `docker compose up --build` This will rebuild the images and start the containers, this is useful if you have made changes to the project and want to see them reflected in the running site.
* `docker compose watch` This will start the containers and watch the default models folder, this means that if the project uses source code models builder the images automatically rebuilds and restarts when you change the models.

## Details

The docker compose file uses bind mounts for the following folders:

* /wwwroot/media
* /wwwroot/scripts
* /wwwroot/css
* /Views
* /models

This is bad for production, however, for local development this means that the files necessary for development are available from outside the container in your IDE allowing you to effectively develop even though the project is running in docker.

## Template options

The `umbraco-compose` template has a few options that can be used to customize the setup:

* -P or --project-name: The name of the project, this is required and used to set the correct paths in the docker-compose file.
* -dbpw or --DatabasePasswor: Used to specify the database password, this is stored in the .env file, defaults to: Password1234
* -p or --Port: Used to specify the port the site will run on, defaults to 44372
