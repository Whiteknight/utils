#!/bin/bash

docker run -d \
    -e "ACCEPT_EULA=Y" \
    -e "MSSQL_SA_PASSWORD=strongPassword123!" \
    -p 1433:1433 \
    --name sqlserver \
    -v 'C:\\containers\\sqlserver\\data:/var/opt/mssql/data' \
    -v 'C:\\containers\\sqlserver\\log:/var/opt/mssql/log' \
    -v 'C:\\containers\\sqlserver\\secrets:/var/opt/mssql/secrets' \
    mcr.microsoft.com/mssql/server:2022-latest 

echo login with sa / strongPassword123!

echo sqlcmd -S localhost -U SA -P 'strongPassword123!'