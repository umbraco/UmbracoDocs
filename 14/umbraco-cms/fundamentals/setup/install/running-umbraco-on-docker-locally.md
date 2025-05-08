---
description: Running Umbraco on docker locally using docker compose
---

# Running Umbraco in Docker using Docker Compose

This article shows how to run Umbraco locally in Docker using Docker Compose. You can use either SQL Server or SQLite for development.

{% hint style="info" %}
This setup is intended for local development only. It is not recommended for production environments.
{% endhint %}

## Prerequisites

Before you can run Umbraco in Docker, make sure the following are installed:

* .NET SDK with Umbraco Templates v14.3.0 or higher
* Docker Desktop

## Installing

To install Umbraco using the provided Dockerfile and Docker Compose setup, follow these steps:

### Option 1: Using SQL Server

1. Create a folder and navigate into it:

```bash
mkdir MyDockerProject
cd MyDockerProject
```

2. Create a new Umbraco project with Docker support:

```csharp
dotnet new umbraco -n MyDockerProject --add-docker
```

3. Add Docker Compose files:

```csharp
dotnet new umbraco-compose -P "MyDockerProject"
```

The `-P` flag is required to specify the correct paths in the docker-compose file. The project is now ready to run with Docker Compose.

The folder structure should now look like this:

* MyDockerProject/
  * Database/
    * Dockerfile
    * healthcheck.sh
    * setup.sql
    * startup.sh
  * MyDockerProject/
    * Your project files
    * Dockerfile
    * .dockerignore
  * .env
  * docker-compose.yml

The project now includes docker files for both Umbraco and the SQL server database.

It also includes additional scripts to launch and configure the database and a `.env` file with the database password.

4. Run the following command from the root folder (where `docker-compose.yml` is located):

```bash
docker compose up
```

5. Access the site at `http://localhost:44372`.

### Option 2: Using SQLite

1. Create a new folder and navigate into it:

```bash
mkdir MyDockerSqliteProject
cd MyDockerSqliteProject
```

2. Create a new Umbraco project:

```csharp
dotnet new umbraco -n MyDockerSqliteProject
```

3. Add a Dockerfile

{% code overflow="wrap" fullWidth="false" %}
```bash
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
EXPOSE 8080

FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["MyDockerSqliteProject/MyDockerSqliteProject.csproj", "MyDockerSqliteProject/"]
RUN dotnet restore "MyDockerSqliteProject/MyDockerSqliteProject.csproj"
COPY . .
WORKDIR "/src/MyDockerSqliteProject"
RUN dotnet build "MyDockerSqliteProject.csproj" -c  $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
RUN dotnet publish "MyDockerSqliteProject.csproj" -c  $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "MyDockerSqliteProject.dll"]
```
{% endcode %}

{% hint style="info" %}
To speed up the build process, add a `.dockerignore` file to exclude unnecessary folders like `.git`, `bin`, and `obj`.
{% endhint %}

4. Build the container:

```bash
docker build -t umbraco-sqlite .
```

5. Run the container:

```bash
docker run -p 8080:8080 umbraco-sqlite
```

6. Access the site at `http://localhost:8080`.

## Useful Commands

There are some useful commands you can use to manage the docker containers:

* `docker compose down --volumes`: Deletes containers and the volumes they use. This is useful if you want to start from scratch.

{% hint style="warning" %}
Be careful with this command, as it deletes your database and all data in it.
{% endhint %}

* `docker compose up --build`: Rebuild the images and start the containers. This is useful if you have made changes to the project and want to see them reflected on the running site.
* `docker compose watch`: Start the containers and watch the default models folder. This means that if the project uses a source-code models builder the images are automatically rebuilt and restarts when you change the models.

## Bind Mounts (SQL Server setup)

The docker compose file uses bind mounts for the following folders:

* `/wwwroot/media`
* `/wwwroot/scripts`
* `/wwwroot/css`
* `/Views`
* `/models`

This is not meant to be used in production.

For local development, however, this means that the files necessary for development are available from outside the container in your IDE. This allows development even though the project is running in docker.

## Template Options (SQL Server only)

The `umbraco-compose` template supports:

* `-P` or `--project-name`: The name of the project. This is required and used to set the correct paths in the docker-compose file.
* `-dbpw` or `--DatabasePassword`: Used to specify the database password. This is stored in the `.env` file and defaults to: `Password1234`.
* `-p` or `--Port`: Used to specify the port the site will run on. Defaults to `44372`.
