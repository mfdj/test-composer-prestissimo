#!/usr/bin/env bash

USER=mageuser
PASS=blahgento
DATABASES='mage_one mage_two'

if uname -a | grep -q Darwin; then
	echo "Don't run $0 on macOS"
	exit 1
fi

# ~=~=~=~ HELPER FUNCTIONS ~=~=~=~

strict_query() {
	sudo mysql -uroot -e "$1" || {
		echo "Aborting: problem with query '$1'"
		exit 1
	}
}

query() {
	sudo mysql -uroot -e "$1" || {
		echo "Problem with query '$1'"
		return 1
	}
}

silent_query() {
	sudo mysql -uroot -e "$1" &> /dev/null
}

query_match() {
	local query
	query=$1
	shift

	for pattern in "$@"; do
		sudo mysql -uroot -e "$query" | grep -q "$pattern" || {
			return 1
		}
	done
}

query_has_result() {
	sudo mysql -uroot -e "$1" | wc -l | { read line_count; (( line_count > 0 )); } || {
		return 1
	}
}

# ~=~=~=~ PROGRAM ~=~=~=~

query_match 'show databases' 'information_schema' 'mysql' || {
	echo "Problem connecting to MySQL: aborting"
	exit 1
}

[[ $1 == drop-first || $1 == dropfirst ]] && {
	for db in $DATABASES; do
		silent_query "drop database $db"
	done
}

# create database
for db in $DATABASES; do
	query_match 'show databases' "$db" || strict_query "create database $db"
done

# create user
query_has_result "select User from mysql.user where User='$USER' and Host='localhost'" || {
	strict_query "create user $USER@localhost IDENTIFIED BY '$PASS'"
}

# grant access
for db in $DATABASES; do
	strict_query "GRANT ALL ON $db.* TO $USER@localhost"
done

for db in $DATABASES; do
	query "show databases like '%$db%'"
	query "select count(TABLE_NAME) from information_schema.tables where TABLE_SCHEMA='$db'"
done
