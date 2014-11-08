#!/usr/bin/env bash

MYSQL='mysql'
MONGO='/usr/local/mongo/bin/mongo'
MONGOIMPORT='/usr/local/mongo/bin/mongoimport'

SCRIPT_DIR=`dirname $0`

FIND_SQL="$SCRIPT_DIR/find_by_hoby.sql"
GROUP_SQL="$SCRIPT_DIR/group_by_hoby.sql"
SUMMARY_SQL="$SCRIPT_DIR/summary.sql"
FIND_JS="$SCRIPT_DIR/find_by_hoby.js"
GROUP_JS="$SCRIPT_DIR/group_by_hoby.js"
SUMMARY_JS="$SCRIPT_DIR/summary.js"


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

mysql_test
mysql_test

mongo_test
mongo_test



#=== SELECT
# real 0m13.412s
# real 0m13.216s
#
#=== AGGREGATE
# real 0m4.100s
# real 0m3.797s
#
#=== GROUP BY FROM GROUP BY
# real 0m31.000s
# real 0m30.388s

#=== FIND
# real 0m0.185s
# real 0m0.169s
#
#=== GROUP BY
# real 0m22.204s
# real 0m22.698s
#
# === AGGREGATE BY COUNT
# real 0m5.682s
# real 0m5.404s



# === SELECT
# real 1m54.041s
# real 2m3.354s
# === GROUP BY
# real 3m40.450s
# real 3m35.407s
# === GROUP BY FROM GROUP BY
# real 5m43.442s
# real 5m55.947s
#
# === FIND
# real 0m2.848s
# real 0m2.387s
# === AGGREGATE
# real 0m57.204s
# real 0m57.330s
# === AGGREGATE BY COUNT
# real 1m10.533s
# real 1m7.637s



# === FIND
# real    0m48.537s
# real    0m27.982s

# === AGGREGATE
# real    10m59.302s
# real    11m20.171s

# === AGGREGATE BY COUNT
# real    13m28.740s
# real    14m12.852s




# COUNT(people._id)
# 2457917
# +----+-------------+--------+--------+------------------+----------+---------+--------------------+---------+-----------------------+
# | id | select_type | table  | type   | possible_keys    | key      | key_len | ref                | rows    | Extra                 |
# +----+-------------+--------+--------+------------------+----------+---------+--------------------+---------+-----------------------+
# |  1 | SIMPLE      | hobies | ref    | idx_pid,idx_name | idx_name | 23      | const              | 4590572 | Using index condition |
# |  1 | SIMPLE      | people | eq_ref | PRIMARY          | PRIMARY  | 4       | sample.hobies._pid |       1 | Using index           |
# +----+-------------+--------+--------+------------------+----------+---------+--------------------+---------+-----------------------+
# 2 rows in set (0.24 sec)


# {
#  "cursor" : "BtreeCursor hobies_1",
#  "isMultiKey" : true,
#  "n" : 2457917,
#  "nscannedObjects" : 2457917,
#  "nscanned" : 2457917,
#  "nscannedObjectsAllPlans" : 2457917,
#  "nscannedAllPlans" : 2457917,
#  "scanAndOrder" : false,
#  "indexOnly" : false,
#  "nYields" : 19788,
#  "nChunkSkips" : 0,
#  "millis" : 20068,
#  "indexBounds" : {
#   "hobies" : [
#    [
#     "TV",
#     "TV"
#    ]
#   ]
#  },
#  "server" : "www10162uj.sakura.ne.jp:27017",
#  "filterSet" : false
# }



# [{  "_id" : "tenis",     "count" : 1226853
#  },{ "_id" : "football", "count" : 1227488
#  },{ "_id" : "swim",     "count" : 1227885
#  },{ "_id" : "bicycle",  "count" : 1227898
#  },{ "_id" : "reading",  "count" : 1227982
#  },{ "_id" : "baseball", "count" : 1228441
#  },{ "_id" : "TV",       "count" : 1228567
#  },{ "_id" : "running",  "count" : 1228615
#  },{ "_id" : "golf",     "count" : 1228702
#  },{ "_id" : "chinema",  "count" : 1228725
#  },{ "_id" : "videogame","count" : 1229263
#  },{ "_id" : "drive",    "count" : 1229304
#  },{ "_id" : "cook",     "count" : 1229835
# }]
#
#
# [{   "_id" : 0, "count" : 8406
#  },{ "_id" : 4, "count" : 60083
#  },{ "_id" : 5, "count" : 107735
#  },{ "_id" : 3, "count" : 2396899
#  },{ "_id" : 2, "count" : 6541243
#  },{ "_id" : 1, "count" : 10885634
# }]


