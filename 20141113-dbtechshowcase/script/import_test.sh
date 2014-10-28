#!/usr/bin/env bash

MYSQL='mysql'
MONGO='/usr/local/mongo/bin/mongo'
MONGOIMPORT='/usr/local/mongo/bin/mongoimport'

DIR=`dirname $0`
DATA_DIR="$DIR/../data/"

OPTIONS=`getopt -o n:, -- "$@"`
if [ $? != 0 ] ; then
  exit 1
fi
eval set -- "$OPTIONS"
while true; do
    OPTARG=$2
    case $1 in
				-h|--help)       usage 0 ;;
				-n)      N="${OPTARG}";shift;;
				--) shift;break;;
    esac
		shift
done
if [ "$N" == "" ] ; then
  exit 1
fi

DDL_SQL="$DATA_DIR/ddl.sql"
ALTER_SQL="$DATA_DIR/alter.sql"
ENSURE_INDEX_JS="$DATA_DIR/ensureIndex.js"

DATA_SQL="$DATA_DIR/sample_$N.sql"
DATA_JS="$DATA_DIR/sample_$N.js"

if [ ! -f $DATA_SQL -o ! -f $DATA_JS ] ; then
  echo "== Generate sample data ($N) =="
  mkdir -p $DATA_DIR
  pushd $DATA_DIR
  ruby "../script/gen_sample.rb" $N
	popd
fi


function mysql_test {
  echo "=== Import $DATA_SQL"
  $MYSQL -u root <"$DDL_SQL"
  time bash -c "$MYSQL -u root sample <$DATA_SQL > /dev/null"
  echo "=== CREATE INDEX"
  time bash -c "$MYSQL -u root sample <$ALTER_SQL > /dev/null"
}

function mongo_test {
  echo "=== Import $DATA_JS"
  $MONGO --quiet sample <<<'db.dropDatabase()'
  time bash -c "$MONGOIMPORT -d sample -c people $DATA_JS > /dev/null"
  echo "=== ensureIndex"
  time $MONGO --quiet sample $ENSURE_INDEX_JS
}

mysql_test
mysql_test

mongo_test
mongo_test


# Import ./../data//sample_10.sql
# real	1m4.127s
# user	0m4.410s
# sys	0m1.120s
#
# CREATE INDEX
# real	0m24.479s
# user	0m0.002s
# sys	0m0.006s
#
# Import ./../data//sample_1000000.sql
# real	1m29.598s
# user	0m4.598s
# sys	0m1.188s
#
# CREATE INDEX
# real	0m19.055s
# user	0m0.002s
# sys	0m0.005s
#
# Import ./../data//sample_1000000.js
# real	1m17.307s
# user	0m13.642s
# sys	0m2.965s
#
# ensureIndex
# real	0m23.352s
# user	0m0.057s
# sys	0m0.008s
#
# Import ./../data//sample_1000000.js
# real	1m19.022s
# user	0m13.502s
# sys	0m2.719s
#
# ensureIndex
# real	0m23.870s
# user	0m0.052s
# sys	0m0.015s
#