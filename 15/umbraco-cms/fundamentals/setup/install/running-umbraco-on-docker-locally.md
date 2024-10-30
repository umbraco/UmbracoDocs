---
description: "Running Umbraco on docker locally using docker compose"
---

# Running Umbraco in Docker using Docker Compose

To aid in developing Umbraco with additional services, the templates can provide the requisite files to run Umbraco with an SQL Server database in Docker. This setup is designed to be used for local development, and not for production.

## Prerequisites

Before you can run Umbraco in Docker, you need to have the following installed:
* Version 14.3.0 or higher of the Umbraco Templates
* Docker Desktop

## Installing

Installing Umbraco with the Docker file and Docker Compose file is a two-step process.

1. Create a folder to hold your project and enter that folder.

```bash
mkdir MyDockerProject
cd MyDockerProject
```
2. Create your Umbraco project using the Umbraco Templates, and remember to use the `--add-docker` flag to include the Docker files.


Conventionally this is named the same as the folder, but it is not a requirement.

```bash
dotnet new umbraco -n MyDockerProject --add-docker
```

Now we need to add some additional files to make docker compose work. We can do this using the umbraco-compose template, passing the project name we specified earlier to the -P parameter:

```bash
dotnet new umbraco-compose -P "MyDockerProject"
```

The `-P` flag is required to specify the correct paths in the docker-compose file. The project is now ready to run with docker compose.

The final folder structure looks like this:

* MyDockerProject
  * MyDockerProject
    * Typical project files
    * DockerFile
    * `.dockerignore`
  * `.env`
  * Database
    * DockerFile
    * `healthcheck.sh`
    * `setup.sql`
    * `startup.sh`
  * `docker-compose.yml`

The project now includes docker files for both Umbraco and the SQL server database.

It also includes additional scripts to launch and configure the database and a `.env` file with the database password.

## Running

To run the project use the `docker compose up` command in the root of the project files where the `docker-compose.yml` is.

This command will build both the Umbraco and SQL Server images and launch them in the correct order. When the site is booted, access it in your browser on `http://localhost:44372/`.

### Useful commands

There are some useful commands you can use to manage the docker containers:

* `docker compose down --volumes`: Delete your containers and the volumes they use. This is useful if you want to start from scratch.

{% hint style="warning" %}
Be careful with this command, as it deletes your database and all data in it.
{% endhint %}

* `docker compose up --build`: Rebuild the images and start the containers. This is useful if you have made changes to the project and want to see them reflected on the running site.
* `docker compose watch`: Start the containers and watch the default models folder. This means that if the project uses a source-code models builder the images are automatically rebuilt and restarts when you change the models.

## Details

The docker compose file uses bind mounts for the following folders:

* `/wwwroot/media`
* `/wwwroot/scripts`
* `/wwwroot/css`
* `/Views`
* `/models`

This is not meant to be used in production.

For local development, however, this means that the files necessary for development are available from outside the container in your IDE. This allows development even though the project is running in docker.

## Template options

The `umbraco-compose` template has a few options that can be used to customize the setup:

* `-P` or `--project-name`: The name of the project. This is required and used to set the correct paths in the docker-compose file.
* `-dbpw` or `--DatabasePasswor`: Used to specify the database password. This is stored in the `.env` file and defaults to: `Password1234`.
* `-p` or `--Port`: Used to specify the port the site will run on. Defaults to `44372`.
