#!/usr/bin/env bash
set -euoxo pipefail 

wget  https://github.com/goharbor/harbor/releases/download/v2.12.0/harbor-online-installer-v2.12.0.tgz
tar xzvf harbor-online-installer-v2.12.0.tgz

cat <<HARBOR >harbor/harbor.yml
hostname: 192.168.56.43

http:
  port: 80

harbor_admin_password: Harbor12345

database:
  password: root123
  max_idle_conns: 100
  max_open_conns: 900
  conn_max_lifetime: 5m
  conn_max_idle_time: 0

data_volume: /data

trivy:
  ignore_unfixed: false
  skip_update: false
  skip_java_db_update: true
  offline_scan: false
  security_check: vuln,config,secret
  insecure: false
  timeout: 5m0s

jobservice:
  max_job_workers: 10
  job_loggers:
    - STD_OUTPUT
    - FILE
  logger_sweeper_duration: 1 #days

notification:
  webhook_job_max_retry: 3
  webhook_job_http_client_timeout: 3 #seconds

log:
  level: info
  local:
    rotate_count: 50
    rotate_size: 200M
    location: /var/log/harbor

_version: 2.12.0

proxy:
  http_proxy:
  https_proxy:
  no_proxy:
  components:
    - core
    - jobservice
    - trivy

upload_purging:
  enabled: true
  age: 168h
  interval: 24h
  dryrun: false

cache:
  enabled: false
  expire_hours: 24
HARBOR

cat <<DOCKER > /etc/docker/daemon.json
{"insecure-registries":["192.168.56.43:80"]}
DOCKER

harbor/install.sh --with-trivy
