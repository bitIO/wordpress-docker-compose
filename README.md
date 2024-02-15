# WordPress with MySQL and PHP MyAdmin

This example defines one of the basic setups for WordPress. More details on how
this works can be found on the official
[WordPress image page](https://hub.docker.com/_/wordpress).

Project structure:

```txt
.
├── compose.yaml
├── wp-config-docker.php
├── wp-config-sample.php
├── wp-config.php
├── wp-settings.php
└── README.md
```

[_compose.yaml_](compose.yaml)

```yaml
services:
  db:
    # We use a mariadb image which supports both amd64 & arm64 architecture
    image: mariadb:10.6.4-focal
    # If you really want to use MySQL, uncomment the following line
    #image: mysql:8.0.27
    command: '--default-authentication-plugin=mysql_native_password'
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      - MYSQL_ROOT_PASSWORD=somewordpress
      - MYSQL_DATABASE=wordpress
      - MYSQL_USER=wordpress
      - MYSQL_PASSWORD=wordpress
    expose:
      - 3306
      - 33060

  wordpress:
    image: wordpress:latest
    ports:
      - 80:80
    restart: always
    environment:
      - WORDPRESS_DB_HOST=db
      - WORDPRESS_DB_USER=wordpress
      - WORDPRESS_DB_PASSWORD=wordpress
      - WORDPRESS_DB_NAME=wordpress_chapineria
    volumes:
      # Use the following line if you want to use the default wp-content directory
      # - ./wp-content:/var/www/html/wp-content
      # Use the following line if you want to use a custom wp-content directory
      - ./web-chapineria/wp-content:/var/www/html/wp-content
      #  Uncomment the following lines if you want to use custom wp-settings.php and wp-config.php
      # - type: bind
      #   source: ./wp-settings.php
      #   target: /var/www/html/wp-settings.php
      #   read_only: true
      # - type: bind
      #   source: ./wp-config.php
      #   target: /var/www/html/wp-config.php
      #   read_only: true

  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    restart: always
    ports:
      - 8080:80
    environment:
      - PMA_ARBITRARY=1
      - PMA_HOST=db
      - PMA_USER=wordpress
      - PMA_PASSWORD=wordpress

volumes:
  db_data:
```

When deploying this setup, docker compose maps the WordPress container port 80 to
port 80 of the host as specified in the compose file.

> ℹ️ **_INFO_**
> For compatibility purpose between `AMD64` and `ARM64` architecture, we use a MariaDB as database instead of MySQL.
> You still can use the MySQL image by uncommenting the following line in the Compose file
> `#image: mysql:8.0.27`

## Deploy with docker compose

```bash
$ docker compose up -d
Creating network "wordpress-mysql_default" with the default driver
Creating volume "wordpress-mysql_db_data" with default driver
...
Creating wordpress-mysql_db_1        ... done
Creating wordpress-mysql_wordpress_1 ... done
```

### Expected result

Check containers are running and the port mapping:

```bash
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                 NAMES
5fbb4181a069        wordpress:latest    "docker-entrypoint.s…"   35 seconds ago      Up 34 seconds       0.0.0.0:80->80/tcp    wordpress-mysql_wordpress_1
e0884a8d444d        mysql:8.0.19        "docker-entrypoint.s…"   35 seconds ago      Up 34 seconds       3306/tcp, 33060/tcp   wordpress-mysql_db_1
```

Navigate to `http://localhost:80` in your web browser to access WordPress.

### Stop and remove the containers

```bash
docker compose down
```

To remove all WordPress data, delete the named volumes by passing the `-v` parameter:

```bash
docker compose down -v
```
