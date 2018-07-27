#!/bin/sh
#
# All-In Biz version 1.0
# Copyright ⓒ 2016 kt Inc. All rights reserved.
# This is a proprietary software of kt Inc, and you may not use this file except in compliance
# with license agreement with kt Inc. Any redistribution or use of this software, with or without
# modification shall be strictly prohibited without prior written approval of kt Inc, and
# the copyright notice above does not evidence any actual or intended publication of such software.
#

# Start or Stop Script for PostgresSQL
. /Volumes/MicroSD/PostgreSQL/9.5/pg_env.sh

C_DATE=`date +%Y%m%d`
PGCTL=/Volumes/MicroSD/PostgreSQL/9.5/bin/pg_ctl
PGMASTER=/Volumes/MicroSD/PostgreSQL/9.5/bin/postmaster
PGLOG=/Volumes/MicroSD/PostgreSQL/9.5/log
OPT_MASTER="-i"
OPT_PGCTL1="-l"

case "$1" in
        start)
                /bin/echo "Be starting PostgreSQL Server"
                /bin/echo "If you aren't logged on root, Please enter postgres user's password"
                /usr/bin/sudo su -l $PGUSER -c "$PGCTL $OPT_PGCTL1 $PGLOG/pgsql_$C_DATE.log -D $PGDATA  start 2>&1 &"
                ;;
        stop)
                /bin/echo "Be stopping PostgreSQL Server"
                /bin/echo "If you aren't logged on root, Please enter postgres user's password"
                /usr/bin/sudo su -l $PGUSER -c "$PGCTL -m fast -D $PGDATA stop"
                ;;
        restart)
                /bin/echo "Be restarting PostgreSQL Server"
                /bin/echo "If you aren't logged on root, Please enter postgres user's password"
                /usr/bin/sudo su -l $PGUSER -c "$PGCTL -m fast -D $PGDATA stop"
                /bin/echo "It's done with stopping"
                /bin/sleep 3
                /bin/echo "Be starting PostgreSQL Server"
                /bin/echo "If you aren't logged on root, Please enter postgres user's password"
                /usr/bin/sudo su -l $PGUSER -c "$PGCTL $OPT_PGCTL1 $PGLOG/pgsql_$C_DATE.log -D $PGDATA  start 2>&1 &"
                /bin/echo "It's done with starting"
                ;;
        psql-admin)
                /bin/echo "Be starting psql (DB:$PGDATABASE, User:$PGUSER)"
                /Volumes/MicroSD/PostgreSQL/9.5/bin/psql
                ;;
        psql-oozie)
                /bin/echo "Be starting psql (User:OOZIE)"
                /Volumes/MicroSD/PostgreSQL/9.5/bin/psql ooziedb -Uoozie
                ;;
        psql-aib)
                /bin/echo "Be starting psql (User:AIB)"
                /Volumes/MicroSD/PostgreSQL/9.5/bin/psql aib -Uaibdb
                ;;
        *)
                echo "Usage : pg_ctl.sh [Option]"
                echo ""
                echo "Option: start | stop | restart"
                echo "        psql-admin | psql-oozie | psql-aib"
                exit 1
                ;;
esac
exit 0
