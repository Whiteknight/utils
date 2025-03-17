#!/bin/bash -i
# Go to the parserobjects dir, wherever it is
pg castiron

# This key is for a local instance of SonarQube, and needs to be recreated for each new instance
SONARQUBE_CASTIRON_KEY=a967e60e466c8053340aa70541875751df7790ca

# Path to the OpenCover.Console.exe executable
# TODO: see if we can find a way to make this a relative path for a more repeatable process
OPENCOVER_EXE=/c/Users/awhitworth/.nuget/packages/opencover/4.7.922/tools/OpenCover.Console.exe

# Need to setup the containers for various db providers
# Hope that the servers are up and ports are opened by the time we start running tests
docker-compose up -d

# Need to install sonarscanner tool in your local for this to work
# dotnet tool install --global dotnet-sonarscanner --version 4.10.0
dotnet sonarscanner begin \
    -k:CastIron \
    -d:sonar.login=$SONARQUBE_CASTIRON_KEY \
    -d:"sonar.cs.opencover.reportsPaths=coverage.xml"

dotnet build Src/CastIron.sln

$OPENCOVER_EXE \
    -target:"c:\Program Files\dotnet\dotnet.exe" \
    -targetargs:"test Src/CastIron.sln" \
    -output:"coverage.xml" \
    -oldstyle \
    -register:user

echo Committing
dotnet sonarscanner end -d:sonar.login=$SONARQUBE_CASTIRON_KEY

echo Cleaning Up
rm coverage.xml
#docker-compose down -v

# Go back to the sonarqube project dir
pg sonarqube
