#/bin/sh

/usr/bin/mongoimport --host $APP_MONGO_HOST --port $APP_MONGO_PORT --db movie --collection tags --file /usr/share/mongo_data/tags.json
echo "Загружаем tags.json..."

/usr/bin/mongo $APP_MONGO_HOST:$APP_MONGO_PORT/movies
