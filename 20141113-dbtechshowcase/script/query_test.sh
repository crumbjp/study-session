#!/usr/bin/env bash

MYSQL='mysql'
MONGO='/usr/local/mongo/bin/mongo'
MONGOIMPORT='/usr/local/mongo/bin/mongoimport'

DIR=`dirname $0`
DATA_DIR="$DIR/../data/"


FIND_SQL="$DATA_DIR/find_by_hoby.sql"
GROUP_SQL="$DATA_DIR/group_by_hoby.sql"
SUMMARY_SQL="$DATA_DIR/summary.sql"
FIND_JS="$DATA_DIR/find_by_hoby.js"
GROUP_JS="$DATA_DIR/group_by_hoby.js"
SUMMARY_JS="$DATA_DIR/summary.js"


function mysql_test {
  echo "=== SELECT"
  time $MYSQL -u root sample <$FIND_SQL
  echo "=== GROUP BY"
  time $MYSQL -u root sample <$GROUP_SQL
  echo "=== GROUP BY FROM GROUP BY"
  time $MYSQL -u root sample <$SUMMARY_SQL
}

function mongo_test {
  echo "=== FIND"
  time $MONGO sample $FIND_JS
  echo "=== AGGREGATE"
  time $MONGO sample $GROUP_JS
  echo "=== AGGREGATE BY COUNT"
  time $MONGO sample $SUMMARY_JS
}

# mysql_test
# mysql_test

mongo_test
mongo_test



#=== SELECT
# real	0m13.412s
# real	0m13.216s
#
#=== FIND
# real	0m0.185s
# real	0m0.169s
#
#=== GROUP BY
# real	0m22.204s
# real	0m22.698s
#
#=== AGGREGATE
# real	0m4.100s
# real	0m3.797s
#
#=== GROUP BY FROM GROUP BY
# real	0m31.000s
# real	0m30.388s

# === AGGREGATE BY COUNT
# real	0m5.682s
# real	0m5.404s
