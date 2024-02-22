#!/bin/bash

echo "Creating admin user"
mysql wordpress -u root -p$MYSQL_ROOT_PASSWORD -e "INSERT INTO wp_users (user_login, user_pass, user_nicename, user_email, user_url, user_registered, user_activation_key, user_status, display_name) VALUES ('admin', MD5('admin'), 'admin', 'admin@localhost', '', '2019-01-01 00:00:00', '', 0, 'admin');"

# Get created user id
USER_ID=$(mysql wordpress -u root -p$MYSQL_ROOT_PASSWORD -D $MYSQL_DATABASE -se "SELECT ID FROM wp_users WHERE user_login='admin';")

MAX_UMEAT_ID=$(mysql wordpress -u root -p$MYSQL_ROOT_PASSWORD -D $MYSQL_DATABASE -se "SELECT MAX(umeta_id) FROM wp_usermeta;")

# Insert user meta
mysql wordpress -u root -p$MYSQL_ROOT_PASSWORD -e "INSERT INTO wp_usermeta (umeta_id, user_id, meta_key, meta_value) VALUES (NULL, '$USER_ID', 'wp_capabilities', 'a:1:{s:13:\"administrator\";s:1:\"1\";}');"
mysql wordpress -u root -p$MYSQL_ROOT_PASSWORD -e "INSERT INTO wp_usermeta (umeta_id, user_id, meta_key, meta_value) VALUES (NULL, '$USER_ID', 'wp_user_level', '10');"

echo "Admin user created"