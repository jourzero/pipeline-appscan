# Starting Damn Vulnerable Node App (DVNA)

   - Start test app via `./1-start-dvna.sh`:

        ```bash
        $ ./2-start-dvna.sh 
        Creating network "0-setup_default" with the default driver
        Creating dvna ... done
        Attaching to dvna
        dvna       | 
        dvna       | > dvna@0.0.1 start /app
        dvna       | > node server.js
        dvna       | 
        dvna       | Mon, 03 Jun 2019 23:39:35 GMT sequelize deprecated String based operators are now deprecated. Please use Symbol based operators for better security, read more at http://docs.sequelizejs.com/manual/tutorial/querying.html#operators at node_modules/sequelize/lib/sequelize.js:242:13
        dvna       | Executing (default): SELECT 1+1 AS result
        dvna       | Executing (default): CREATE TABLE IF NOT EXISTS `Products` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `code` VARCHAR(255) NOT NULL UNIQUE, `name` VARCHAR(255) NOT NULL, `description` TEXT NOT NULL, `tags` VARCHAR(255), `createdAt` DATETIME NOT NULL, `updatedAt` DATETIME NOT NULL);
        dvna       | Connection has been established successfully.
        dvna       | Executing (default): PRAGMA INDEX_LIST(`Products`)
        dvna       | Executing (default): PRAGMA INDEX_INFO(`sqlite_autoindex_Products_1`)
        dvna       | Executing (default): CREATE TABLE IF NOT EXISTS `Users` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` VARCHAR(255) NOT NULL, `login` VARCHAR(255) NOT NULL UNIQUE, `email` VARCHAR(255) NOT NULL, `password` VARCHAR(255) NOT NULL, `role` VARCHAR(255), `createdAt` DATETIME NOT NULL, `updatedAt` DATETIME NOT NULL);
        dvna       | Executing (default): PRAGMA INDEX_LIST(`Users`)
        dvna       | Executing (default): PRAGMA INDEX_INFO(`sqlite_autoindex_Users_1`)
        dvna       | It worked!
        ```
    - On the Docker host, add an entry in its host file for the test app: `echo "127.0.0.1 dvna" >> /etc/hosts`
    - Browse from host to test app at http://dvna:9090 or http://localhost:8080
        -  NOTE: all Docker containers will access the test app using the host name _dvna_ to access it (as per the name used in docker-compose.yml files).
    - Create a test account by clicking _Register a new account_ and using Login __tester__ Password __tester123__

    - Test new account and credentials 