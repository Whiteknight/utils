#!/bin/bash -i
# Go to the parserobjects dir, wherever it is
pg parserobjects

# This key is for a local instance of SonarQube, and needs to be recreated for each new instance
SONARQUBE_PARSEROBJECTS_KEY=3ce2a9457a631ece9e2e089e027b11837ab3e1fc

# Path to the OpenCover.Console.exe executable
# TODO: see if we can find a way to make this a relative path for a more repeatable process
OPENCOVER_EXE=/c/Users/awhitworth/.nuget/packages/opencover/4.7.922/tools/OpenCover.Console.exe

# Need to install sonarscanner tool in your local for this to work
# dotnet tool install --global dotnet-sonarscanner --version 4.10.0
dotnet sonarscanner begin \
    -k:ParserObjects \
    -d:sonar.login=$SONARQUBE_PARSEROBJECTS_KEY \
    -d:"sonar.cs.opencover.reportsPaths=coverage.xml"

dotnet build ParserObjects.sln

$OPENCOVER_EXE \
    -target:"c:\Program Files\dotnet\dotnet.exe" \
    -targetargs:"test ParserObjects.sln" \
    -output:"coverage.xml" \
    -oldstyle \
    -register:user

dotnet sonarscanner end -d:sonar.login=$SONARQUBE_PARSEROBJECTS_KEY
rm coverage.xml

# Go back to the sonarqube project dir
pg sonarqube