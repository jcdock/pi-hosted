#!/bin/bash

function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

function check_internet() {
  printf "Checking if you are online..."
  wget -q --spider http://github.com
  if [ $? -eq 0 ]; then
    echo "Online. Continuing."
  else
    error "Offline. Go connect to the internet then run the script again."
  fi
}

check_internet

echo "Creating directories..."
sudo mkdir -p /srv/dev-disk-by-uuid-617daa2d-7799-4e67-be38-d6c83cd01e14/containers/prometheus/config || error "Failed to create config directory!"
sudo mkdir -p /srv/dev-disk-by-uuid-617daa2d-7799-4e67-be38-d6c83cd01e14/containers/prometheus/data || error "Failed to create data directory for Prometheus!"
sudo mkdir -p /srv/dev-disk-by-uuid-617daa2d-7799-4e67-be38-d6c83cd01e14/containers/grafana/data || error "Failed to create data directory for Grafana!"
echo "Downloading Prometheus config files"
sudo wget -O /srv/dev-disk-by-uuid-617daa2d-7799-4e67-be38-d6c83cd01e14/containers/prometheus/config/prometheus.yml https://raw.githubusercontent.com/oijkn/Docker-Raspberry-PI-Monitoring/main/prometheus/prometheus.yml || error "Failed to download prometheus.yml file!"
sudo touch /srv/dev-disk-by-uuid-617daa2d-7799-4e67-be38-d6c83cd01e14/containers/grafana/grafana.ini || error "Failed to touch grafana.ini file!"
echo "Setting permissions..."
sudo chown -R 472:472 /srv/dev-disk-by-uuid-617daa2d-7799-4e67-be38-d6c83cd01e14/containers/grafana/data || error "Failed to set permissions for Grafana data!"
echo "Done You are ready to goto next step in the install document"
