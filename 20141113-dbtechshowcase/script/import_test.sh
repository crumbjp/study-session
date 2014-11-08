#!/usr/bin/env bash
MYSQL='mysql'
MONGO='/usr/local/mongo/bin/mongo'
MONGOIMPORT='/usr/local/mongo/bin/mongoimport'

SCRIPT_DIR=`dirname $0`
DATA_DIR="$SCRIPT_DIR/../data/"

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

DDL_SQL="$SCRIPT_DIR/ddl.sql"
ALTER_SQL="$SCRIPT_DIR/alter.sql"
ENSURE_INDEX_SQL="$SCRIPT_DIR/ensureIndex.sql"
ENSURE_INDEX_JS="$SCRIPT_DIR/ensureIndex.js"

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
  echo "=== RELATION INDEX"
  time bash -c "$MYSQL -u root sample <$ALTER_SQL > /dev/null"
  echo "=== CREATE INDEX"
  time bash -c "$MYSQL -u root sample <$ENSURE_INDEX_SQL > /dev/null"
}

function mongo_test {
  echo "=== Import $DATA_JS"
  $MONGO --quiet sample <<<'db.dropDatabase()'
  time bash -c "$MONGOIMPORT -d sample -c people $DATA_JS > /dev/null"
  echo "=== ENSURE INDEX"
  time bash -c "$MONGO --quiet sample $ENSURE_INDEX_JS > /dev/null"
}

# =mysql_test
#mysql_test

mongo_test
mongo_test


# === Import ./../data//sample_10.sql
# real	1m4.127s
# user	0m4.410s
# sys	0m1.120s
#
# CREATE INDEX
# real	0m24.479s
# user	0m0.002s
# sys	0m0.006s
#
# === Import ./../data//sample_1000000.sql
# real	1m29.598s
# user	0m4.598s
# sys	0m1.188s
#
# CREATE INDEX
# real	0m19.055s
# user	0m0.002s
# sys	0m0.005s
#
# === Import ./../data//sample_1000000.js
# real	1m17.307s
# user	0m13.642s
# sys	0m2.965s
#
# === ensureIndex
# real	0m23.352s
# user	0m0.057s
# sys	0m0.008s
#
# === Import ./../data//sample_1000000.js
# real	1m19.022s
# user	0m13.502s
# sys	0m2.719s
#
# === ensureIndex
# real	0m23.870s
# user	0m0.052s
# sys	0m0.015s
#

# === Import ./../data//sample_1000000.js (journal)
# real	1m33.703s
# user	0m13.722s
# sys	0m2.882s
#
# === ensureIndex
#
# real	0m44.285s
# user	0m0.152s
# sys	0m0.142s
# === Import ./../data//sample_1000000.js (journal)
#
# real	1m37.764s
# user	0m13.618s
# sys	0m2.844s
# === ensureIndex
#
# real	0m39.875s
# user	0m0.115s
# sys	0m0.082s







# === Import script/../data//sample_10000000.sql
#
# real    11m14.307s
# user    0m47.187s
# sys     0m11.343s
# === RELATION INDEX
#
# real    1m59.283s
# user    0m0.004s
# sys     0m0.007s
# === CREATE INDEX
#
# real    3m56.211s
# user    0m0.008s
# sys     0m0.007s
# === Import script/../data//sample_10000000.sql
#
# real    11m31.186s
# user    0m46.906s
# sys     0m11.814s
# === RELATION INDEX
#
# real    1m59.542s
# user    0m0.003s
# sys     0m0.010s
# === CREATE INDEX
#
# real    3m54.540s
# user    0m0.006s
# sys     0m0.006s
# === Import script/../data//sample_10000000.js
#
# real    13m5.031s
# user    2m12.989s
# sys     0m27.708s
# === ENSURE INDEX
#
# real    7m27.809s
# user    0m0.839s
# sys     0m1.444s
# === Import script/../data//sample_10000000.js
#
# real    13m3.843s
# user    2m11.858s
# sys     0m26.936s
# === ENSURE INDEX
#
# real    7m12.499s
# user    0m0.845s
# sys     0m1.389s

# === Import script/../data//sample_100000000.js
# real    264m19.817s
# user    24m13.975s
# sys     5m12.147s
# real    219m19.955s
# user    23m42.124s
# sys     5m0.262s
#
# === ENSURE INDEX
# real    496m41.948s
# user    1m13.679s
# sys     2m4.523s
# real    311m0.876s
# user    0m36.754s
# sys     1m0.721s
