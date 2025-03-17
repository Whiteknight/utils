
## Create the Container

    // Create the container if it does not exist
    docker run -d \
        -p3306:3306 \
        --name mysql \
        -e MYSQL_ROOT_PASSWORD=strongPassword123! \
        mysql:8.0;

    // If the container already exists, you can start it with 
    docker start mysql

## Enable external access

To access this container from, for example, a client program:

    // log in to the server to enable permissions. 
    // When prompted use the password 'strongPassword123!'
    $ docker run -it mysql-connect bash

    bash-5.1# mysql -u root -p

    mysql> CREATE USER 'my-user-name'@'my-ip-address' identified by 'my-password';
    mysql> GRANT ALL PRIVILEGES ON *.* to my-user-name@my-ip-address WITH GRANT OPTON;
    mysql> quit

    bash-5.1# exit

**Note**: The username can be any username you want.
**Note**: The ip address is the address of the host system from the point of view of the mysql container. Probably `172.17.0.1`.
