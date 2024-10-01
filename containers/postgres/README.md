# Postgres

## Run DB in Container

(obviously change the name of the data directory to match wherever you want it to be)

    docker run -d \
        --name postgres \
        -e POSTGRES_PASSWORD=strongPassword123! \
        -p 5432:5432 \
        -v 'C:\\containers\\postgres\\data:/var/lib/postgresql/data' \
        postgres

Download the postgres installer, but only need to install `pgadmin` and `Command Line Tools`.

## Command Line Interface

* https://tomcam.github.io/postgres/
* https://www.postgresql.org/docs/current/libpq-pgpass.html

The default login is user:'postgres' password:'strongPassword123!'. Create a file `%APPDATA%\postgresql\pgpass.conf` with the following line in it:

    localhost:*:*:postgres:strongPassword123!

That file will automatically apply your password when you attempt to log into the system.

Log in to the CLI client (the password should automatically apply, if you did the above step correctly):

    psql -U postgres

You can log out of the client by typing `\q`

**NOTICE**: Every command you type must end with a `;`. If the command does not end with `;` it will not be sent to the server, and will instead be included with the batch next time you do type `;`.


