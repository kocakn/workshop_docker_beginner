# Описание выполняемых команд Docker для подключения к MongoDB

### 1. Сеть proj_network с типом bridge имеем, к ней надо подключить контейнер mongo-client (запустить из директории workshop_docker) и смонтировать в него директорию data_store/raw_data
```
docker run --name mongo-client --network proj_network --rm -v "$(pwd)/data_store/raw_data:/usr/share/mongo_data" -d mongo:4.1.6
```

### 2. Пробуем использовать контейнер с помощью команды exec, заливаем в MongoDB файл tags.json
```
docker exec -it mongo-client "/usr/bin/mongoimport --db movie --collection tags --file /usr/share/mongo_data/tags.json"
```

В выводе получается:
```
OCI runtime exec failed: exec failed: container_linux.go:349: starting container process caused "exec: \"/usr/bin/mongoimport --db movie --collection tags --file /usr/share/mongo_data/tags.json\": stat /usr/bin/mongoimport --db movie --collection tags --file /usr/share/mongo_data/tags.json: no such file or directory": unknown
```

Альтернативный вариант команды 1:
```
docker exec -it mongo-client "/usr/bin/mongoimport --host mongo-client --port 27017 --db movie --collection tags --file /usr/share/mongo_data/tags.json"
```
Вывод:
```
OCI runtime exec failed: exec failed: container_linux.go:349: starting container process caused "exec: \"/usr/bin/mongoimport --host mongo-client --port 27017 --db movie --collection tags --file /usr/share/mongo_data/tags.json\": stat /usr/bin/mongoimport --host mongo-client --port 27017 --db movie --collection tags --file /usr/share/mongo_data/tags.json: no such file or directory": unknown
```

Альтернативный вариант команды 2:
```
docker exec -it mongo-client "/usr/bin/mongoimport --host $APP_MONGO_HOST --port $APP_MONGO_PORT --db movie --collection tags --file /usr/share/mongo_data/tags.json"
```
Вывод:
```
OCI runtime exec failed: exec failed: container_linux.go:349: starting container process caused "exec: \"/usr/bin/mongoimport --host  --port  --db movie --collection tags --file /usr/share/mongo_data/tags.json\": stat /usr/bin/mongoimport --host  --port  --db movie --collection tags --file /usr/share/mongo_data/tags.json: no such file or directory": unknown
```

___
