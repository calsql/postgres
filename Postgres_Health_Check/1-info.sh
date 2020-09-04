#!/bin/bash

# first, we collect system info with a series of shell commands.
# this will be followed by the execution of a series of sql scripts
# in order to gather info about the cluster.

# the echoed output is pretty much what is needed, but note that
# the /proc info for some are being saved in their entirety for
# later reference (which is often needed)

### SYSTEM INFO

# loop through all queries in the 'sysinfo' subdirectory
# and save results to individual files

# TODO:
# also save delimited results for processing with python
echo
echo -e "\033[35m             ~~~~~~GATHERING POSTGRES CLUSTER AND DATABASE INFORMATION~~~~~~\e[39m"
echo
echo "This script will skip gathering stats for POSTGRES, TEMPLATE0 and TEMPLATE1 Databases."
USER='postgres'
echo "'POSTGRES' user will be used to gather Database Stats. Make sure you have access to this User."
echo -e "\033[31m   
     A NOTE REGARDING DB PASSWORDS:\e[39m
In case you are being prompted for database 
password for every script, make sure there 
is an entry in .pgpass file for postgres 
user in your cluster.
"
read -p 'Enter Postgres Binary Path:  ' BINPATH;
read -p 'Enter Postgres Cluster Port: ' PORT;
echo
echo "Generating Output Directories...."
echo
svrpath="Report/Server_info/$PORT"
dbpath="Report/Cluster_info/$PORT"
mkdir -p $svrpath $dbpath
find $svrpath/ -name '*txt' -delete
find $dbpath/ -name '*txt' -delete

echo "Gathering Server Information..."
echo
for shell_script in $(ls sysinfo/*.sh); do
        file=${shell_script#*/}
	sh $shell_script > ${svrpath}/${file%%.*}.txt
done
echo -e "Server Stats generated at \033[32m`pwd`/${svrpath}\e[39m Directory."
echo

# A NOTE REGARDING DB PASSWORDS:
# Once ran into a situation where I was prompted for a password
# for every script because customer was using a .pgpass file that
# had an entry for the default db, but not for the production
# database.  pg-hba.conf was set to md5 for all.  Creating a new entry
# .pgpass for the prod db was the solution.

# Run each script 3 times for each database outputting a different format each time.
# Database specific scripts are in dbinfo/db-specific/

# make a new directory for each database
#mkdir -p $dbpath/$DATABASE
echo "Gathering Database Information..."
echo
for DATABASE in `$BINPATH/psql -U $USER -p $PORT -qt -c 'select datname from pg_database;'`; do
	
	# skip if one of the default databases
        if [[ $DATABASE =~ ^(postgres|template0|template1)$ ]]; then echo "Skipping stats for Database $DATABASE.";continue; fi
                echo "Gathering Information on $DATABASE Database"
        dname="$dbpath/${DATABASE}_database_stats"
        mkdir -p $dname 
        for sql_script in $(ls dbinfo/db-specific/*.sql); do
                file=${sql_script##dbinfo\/db-specific\/}
                #echo 'Executing File '$file
		# txt output
                $BINPATH/psql --no-psqlrc --pset columns=100 --pset format=wrapped -p $PORT -f $sql_script -o $dname/${file%%.*}.txt $DATABASE $USER
		# csv output
        #        $BINPATH/psql --no-psqlrc -A -F ',' -p $PORT -f $sql_script -o dbinfo/$PORT/$DATABASE/${file%%.*}.csv $DATABASE $USER
		# html output
        #        $BINPATH/psql --no-psqlrc -H -p $PORT -f $sql_script -o dbinfo/$PORT/$DATABASE/${file%%.*}.html $DATABASE $USER
        done
done
echo
# database generic scripts are only run once for the cluster
# reset to default db (postgres)
DATABASE=postgres
echo "Gathering Cluster Information..."
for sql_script in $(ls dbinfo/*.sql); do
	file=${sql_script##dbinfo\/}
	# txt output
        $BINPATH/psql --no-psqlrc --pset columns=100 --pset format=wrapped -p $PORT -f $sql_script -o $dbpath/${file%%.*}.txt $DATABASE $USER
	# csv output
    #    $BINPATH/psql --no-psqlrc -A -F ',' -p $PORT -f $sql_script -o dbinfo/$PORT/${file%%.*}.csv $DATABASE $USER
	# html output
    #    $BINPATH/psql --no-psqlrc -H -p $PORT -f $sql_script -o dbinfo/$PORT/${file%%.*}.html $DATABASE $USER
done
echo
echo "Gathering Information Completed. "
echo -e "Cluster Stats generated at \033[32m`pwd`/$dbpath\e[39m Directory."
find Report/ -type d|awk 'NR>1'
