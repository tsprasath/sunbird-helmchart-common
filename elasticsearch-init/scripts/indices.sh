#!/bin/bash
until curl -s http://elasticsearch:9200; do
  echo 'Waiting
    for Elasticsearch to be ready...'
  sleep 10
done
echo 'Elasticsearch is ready!'

ls -lrth /opt

cd /opt/indices 

indices_files=$(ls -l | awk 'NR>1{print $9}' | awk -F"." '{print $1}' | tr "\n" " ")
for file in ${indices_files[@]}
do
        curl  -X PUT http://elasticsearch:9200/${file} -H 'Content-Type: application/json' -d @${file}.json
done