#!/bin/bash -i
pg stonefruit

# This key is for a local instance of SonarQube, and needs to be recreated for each new instance
SONARQUBE_STONEFRUIT_KEY=8d8040a272c0bbeb6057b1b736c41b3ba55d1e47

# Path to the OpenCover.Console.exe executable
# TODO: see if we can find a way to make this a relative path for a more repeatable process
OPENCOVER_EXE=/c/Users/awhitworth/.nuget/packages/opencover/4.7.922/tools/OpenCover.Console.exe

dotnet sonarscanner begin \
    -d:sonar.login=$SONARQUBE_STONEFRUIT_KEY \
    -k:StoneFruit \
    -d:"sonar.cs.opencover.reportsPaths=coverage.xml"

dotnet build Src/StoneFruit.sln

$OPENCOVER_EXE \
    -target:"c:\Program Files\dotnet\dotnet.exe" \
    -targetargs:"test Src/StoneFruit.sln" \
    -output:"coverage.xml" \
    -oldstyle \
    -register:user

dotnet sonarscanner end -d:sonar.login=$SONARQUBE_STONEFRUIT_KEY
rm coverage.xml
pg sonarqube