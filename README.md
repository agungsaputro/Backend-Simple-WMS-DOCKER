# STEP DOCKER COMPOSE

## Buat file docker-compose.yml
Bila anda pengguna LInux install docker-compose terlebih dahulu [disini](https://docs.docker.com/compose/install/). Untuk penguna Mac dan Windows docker compose sudah include didalam docker for dekstop. Docker Dekstop bisa di download [disini](https://docs.docker.com/desktop/). oke lanjutssss !!

### 1
kita tuliskan version dari docker compose yang kita gunakan

```
version: "3.7"
```

### 2
tuliskan servise apa saja yang akan kita jalankan pada docker compose ini

```
#service database mysql 
mysql:
    # nama container mysql yang akn di buat
    container_name: guesql
    #image
    image: mysql:latest
    environment:
        #nama user
      - MYSQL_USER=user
        #root password
      - MYSQL_ROOT_PASSWORD=password
        #nama database
      - MYSQL_DATABASE=backend_wms
    #port
    ports:
    # <Port exposed> : < MySQL Port running inside container>
      - 3304:3306
    #network
    networks:
        #nama network
      - network1
```
### 3
kita buat service container backend nya
```
#nama service backend
backend_wms:
    # nama container be nya
    container_name:  container_be
    #image (image yang dibuat kemarin)
    image: 951119/be-docker:2.0
    ports:
    # <Port exposed> : < Port running inside container>
      - 1002:3000
    #service database yang kita buat tadi 
    depends_on:
      - mysql
    command: bash -c "npx sequelize-cli db:migrate"
    networks:
      - network1
```
### 4
kita buat network untuk menyambungkan database dan backend
```
networks:
  network1:
    name: network1
```

file lengkapnya
```
version: "3.7"
services:
  mysql:
    # nama container mysql
    container_name: guesql
    image: mysql:latest
    environment:
      - MYSQL_USER=user
      - MYSQL_ROOT_PASSWORD=password
      - MYSQL_DATABASE=backend_wms
    ports:
    # <Port exposed> : < MySQL Port running inside container>
      - 3304:3306
    networks:
      - network1
  backend_wms:
    # nama container be nya
    container_name:  container_be
    image: 951119/be-docker:2.0
    ports:
    # <Port exposed> : < Port running inside container>
      - 1002:3000
    depends_on:
      - mysql
    networks:
      - network1
networks:
  network1:
    name: network1
```
### 5
menjalankan docker compose
```
docker-compose up -d

```
### 6
menghentikan docker compose
```
docker-compose down

```

### 7

migrate database
```
docker exec -it {id container} bash

```
masuk didalam file root container, jalankan perintah

```
npx sequelize-cli db:migrate

```

### 8
lihat container sudah running dengan perintah

```
docker ps

```
atau
```
docker container ls -a

```