#!/bin/bash -e

case "$1" in
  load)
    bash load_data_mongo.sh
    ;;
  *)
    exec "$@"
esac
