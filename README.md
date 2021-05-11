## Install Dependencies
* [docker](https://docs.docker.com/engine/install/ubuntu/)
* [docker-compose](https://docs.docker.com/compose/install/)
* [node 10](https://nodejs.org/en/download/) maybe works with v12


## Windows aditional dependencies (Requires revision)

1) Install visual studio
2) Run:
```bash
npm install --global --production windows-build-toolsnpm config set msvs_version 2017 --global
```

3) node 12?

Another option:
[WSL 2]
(https://docs.microsoft.com/en-us/windows/wsl/install-win10)

```bash
npm install --global --production windows-build-toolsnpm config set msvs_version 2015 --global
```

## Linux Dependencies

```bash
./install-dependencies.sh
```

# Runing

## docker-compose

```bash
  ./init.sh
  ./up.sh
  ./down.sh
```

Deploys Kafka, Mongodb and Kafka.

Mongo-express: http://localhost:8081
Sawtooth-explorer: http://localhost:8091
Sawtooth-rest-api: http://localhost:8008


## Code:
In `./app/` there are scripts to test sawtooth, kafka and mongo.

`tp1` has the transaction procesor (similar to a smart contract). This transaction processor stores a value with a key like a map or hashtable.

## Suggestions
Edit `up.sh` to only run the code that is required.
Edit `./docker-compose/docker-compose.yaml` so that only the required containers are run
