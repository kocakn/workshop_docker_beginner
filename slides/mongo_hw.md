# Описание выполняемых команд Docker для подключения к MongoDB
____

### 1. Сеть proj_network с типом bridge имеем, к ней надо подключить контейнер mongo-server (запустить из директории workshop_docker)
```
docker run --name mongo-server --network proj_network -v "$(pwd)/data_store/mongo_data:/var/lib/mongodb/data" -d mongo:4.1.6
```

### 2. Пробуем использовать контейнер, подключившись к нему из клиента (запустить из директории workshop_docker)
```
docker run -it --rm --network proj_network -v "$(pwd)/data_store/raw_data:/usr/share/raw_data" mongo:4.1.6 bash
```

В выводе получается:
```
root@0b4c0a06aa55:/#
```

### 3. Заливаем в MongoDB файл tags.json с помощью следующей команды
```
/usr/bin/mongoimport --host mongo-server --port 27017 --db movie --collection tags --file /usr/share/raw_data/tags.json
```

В выводе получается следующее:
```
2020-10-14T15:40:39.709+0000	connected to: mongo-server:27017
2020-10-14T15:40:41.569+0000	imported 91106 documents
```

### 4. Проверяем, что данные успешно попали в MongoDB
```
/usr/bin/mongo mongo-server:27017/movies
```

В выводе получается следующее:
```
MongoDB shell version v4.1.6
connecting to: mongodb://mongo-server:27017/movies?gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("5a82bd93-cb93-4a40-9019-8e519608d478") }
MongoDB server version: 4.1.6
Welcome to the MongoDB shell.
For interactive help, type "help".
For more comprehensive documentation, see
	http://docs.mongodb.org/
Questions? Try the support group
	http://groups.google.com/group/mongodb-user
Server has startup warnings: 
2020-10-14T15:34:30.795+0000 I STORAGE  [initandlisten] 
2020-10-14T15:34:30.795+0000 I STORAGE  [initandlisten] ** WARNING: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine
2020-10-14T15:34:30.795+0000 I STORAGE  [initandlisten] **          See http://dochub.mongodb.org/core/prodnotes-filesystem
2020-10-14T15:34:32.362+0000 I CONTROL  [initandlisten] 
2020-10-14T15:34:32.362+0000 I CONTROL  [initandlisten] ** NOTE: This is a development version (4.1.6) of MongoDB.
2020-10-14T15:34:32.362+0000 I CONTROL  [initandlisten] **       Not recommended for production.
2020-10-14T15:34:32.362+0000 I CONTROL  [initandlisten] 
2020-10-14T15:34:32.362+0000 I CONTROL  [initandlisten] ** WARNING: Access control is not enabled for the database.
2020-10-14T15:34:32.362+0000 I CONTROL  [initandlisten] **          Read and write access to data and configuration is unrestricted.
2020-10-14T15:34:32.362+0000 I CONTROL  [initandlisten] 
---
Enable MongoDB's free cloud-based monitoring service, which will then receive and display
metrics about your deployment (disk utilization, CPU, operation statistics, etc).

The monitoring data will be available on a MongoDB website with a unique URL accessible to you
and anyone you share the URL with. MongoDB may use this information to make product
improvements and to suggest MongoDB products and deployment options to you.

To enable free monitoring, run the following command: db.enableFreeMonitoring()
To permanently disable this reminder, run the following command: db.disableFreeMonitoring()
```

### 5. Пробуем сделать запись через docker-compose
```
sudo SOURCE_DIR=$(pwd) docker-compose --project-name data-cli -f docker-compose.yml run --rm --name mongo-cli mongo-cli load
```

В выводе получается следующее:
```
Creating network "data-cli_proj_network" with driver "bridge"
Creating data-cli_mongo-cli_run ... done
/usr/local/bin/docker-entrypoint.sh: line 342: exec: load: not found
```

____

### 6. Дополнительные испробованные команды
```
SOURCE_DIR=$(pwd) docker-compose --project-name data-cli -f docker-compose.yml run --name mongo-client --rm mongo-cli mongo db.find()
SOURCE_DIR=$(pwd) docker-compose --project-name data-cli -f docker-compose.yml run --name mongo-client --rm mongo-cli mongo "SELECT COUNT(*) FROM tags;"
SOURCE_DIR=$(pwd) docker-compose --project-name data-cli -f docker-compose.yml run --name mongo-client --rm mongo-cli mongo "db.find()"
SOURCE_DIR=$(pwd) docker-compose --project-name data-cli -f docker-compose.yml run --name mongo-client --rm mongo-cli mongo "db"
SOURCE_DIR=$(pwd) docker-compose --project-name data-cli -f docker-compose.yml run --name mongo-client --rm mongo-cli mongo db
```
