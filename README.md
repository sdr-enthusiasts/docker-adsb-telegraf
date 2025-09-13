# docker-telegraf-adsb
Telegraf container for readsb and dump978


```yaml
services:

  telegraf_adsb:
    image: ghcr.io/sdr-enthusiasts/docker-telegraf-adsb:latest
    container_name: telegraf_adsb
    hostname: telegraf_adsb
    restart: unless-stopped
    environment:
      - PROMETHEUS_ENABLE=true
      #- URL_1090=http://192.168.2.23:8080
      #- URL_1090=http://192.168.2.23/tar1090
      - URL_1090=http://ultrafeeder # refrence container directly if in same stack
      #- HOST_978=192.168.2.33
      - HOST_978=dump978 # referene container directly if in same stack
      - LAT=${FEEDER_LAT}
      - LON=${FEEDER_LONG}
    ports:
      - 9273:9273
    tmpfs:
      - /run:exec,size=64M
```

### Output to InfluxDBv2

In order for Telegraf to output metrics to an [InfluxDBv2](https://docs.influxdata.com/influxdb/) time-series database, the following environment variables can be used:

| Variable            | Description                         |
| ------------------- | ----------------------------------- |
| `INFLUXDBV2_URL`    | The URL of the InfluxDB instance    |
| `INFLUXDBV2_TOKEN`  | The token for authentication        |
| `INFLUXDBV2_ORG`    | InfluxDB Organization to write into |
| `INFLUXDBV2_BUCKET` | Destination bucket to write into    |

### Output to InfluxDBv1.8

In order for Telegraf to output metrics to a legacy[InfluxDBv1](https://docs.influxdata.com/influxdb/v1.8/) time-series database, the following environment variables can be used:

| Variable            | Description                             |
| ------------------- | --------------------------------------- |
| `INFLUXDB_URL`      | The URL of the InfluxDB instance        |
| `INFLUXDB_DATABASE` | database in InfluxDB to store data in   |
| `INFLUXDB_USERNAME` | username to authenticate to InfluxDB as |
| `INFLUXDB_PASSWORD` | password for InfluxDB User              |

### Output to Prometheus

In order for Telegraf to serve a [Prometheus](https://prometheus.io) endpoint, the following environment variables can be used:

| Variable            | Description                                                              |
| ------------------- | ------------------------------------------------------------------------ |
| `PROMETHEUS_ENABLE` | Set to `true` for a Prometheus endpoint on `http://0.0.0.0:9273/metrics` |
