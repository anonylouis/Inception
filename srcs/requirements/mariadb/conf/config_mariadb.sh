#!/bin/bash

#if /var/lib/mysql isn't empty
if [ "$(ls -A /var/lib/mysql)" ]
then
	service mysql start 2> /dev/null;
fi

#Is database already installed ?
if [ -f /is_install ]
then 
	echo "Database already installed"
else
	echo "Configuring $SQL_DATABASE ..."

	#mysql_install_db
	killall mysqld
	mysql_install_db &> /dev/null;
	service mysql start 2> /dev/null;

	#rootpassword, user, privileges ...
	mysql -e "CREATE DATABASE $SQL_DATABASE;";
	mysql -e "CREATE USER IF NOT EXISTS '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD';";
	mysql -e "GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD';";
	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';FLUSH PRIVILEGES;";
	
	#to configure it only one time
	touch /is_install
fi

killall mysqld
echo "database $SQL_DATABASE ready"
mysqld --bind-address=0.0.0.0
