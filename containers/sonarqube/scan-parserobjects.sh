#!/bin/bash -i
# Go to the parserobjects dir, wherever it is
pg parserobjects

# PREREQUISITES
# Make sure sonarscanner is installed
# Make sure OpenCover.Console.exe is installed, on your path, and named "opencover"
# Make sure you have a sonarqube project key for ParserObjects set to env var SQ_PARSEROBJECTS_KEY

# Need to install sonarscanner tool in your local for this to work
# dotnet tool install --global dotnet-sonarscanner --version 4.10.0
dotnet sonarscanner begin \
    -k:ParserObjects \
    -d:sonar.host.url="http://sonarqube.local" \
    -d:sonar.login=$SQ_PARSEROBJECTS_KEY \
    -d:"sonar.cs.opencover.reportsPaths=coverage.xml"

dotnet build ParserObjects.sln

opencover \
    -target:"c:\Program Files\dotnet\dotnet.exe" \
    -targetargs:"test ParserObjects.sln" \
    -output:"coverage.xml" \
    -oldstyle \
    -register:user

dotnet sonarscanner end -d:sonar.login=$SQ_PARSEROBJECTS_KEY
rm coverage.xml

# Go back to the sonarqube project dir
pg sonarqube