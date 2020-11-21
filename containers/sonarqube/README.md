# Setup Sonarqube

## Install OpenCover

```
dotnet add package --global OpenCover
```

This will install it to someplace like `~/.nuget/OpenCover/.../tools/OpenCover.Console.exe` Make sure a shortcut to that called "opencover" is located in %PATH%

## Install SonarScanner

```
dotnet tool install --global dotnet-sonarscanner --version 4.8.0
```

## Setup the Environment

Run ./setup.sh first to make sure the folders and things are created. Only need to do this the first time

## Run the container

```
docker-compose up -d
```

## Setup the Proxy

Make sure nginx is running and configured to proxy `http://sonarqube.local` to `http://localhost:9000`

Update `hosts` file to redirect `sonarqube.local` to `127.0.0.1`

## Browse the Website

Connect in browser to `http://sonarqube.local` (it takes about 30-60s for the service to be responsive)
login as admin:admin

## Setup Projects

Create projects for everything you want to scan, generate a token for each project, and set a global env variable named `SQ_<projectname>_KEY` with the key value
