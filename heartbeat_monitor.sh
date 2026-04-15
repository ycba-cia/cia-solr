#!/bin/bash

count=$(ps -efw | grep "cia-solr" | wc -l)
#echo $count

cd /app/cia-solr
if [[ $count -gt 1 ]]
then
echo "ciasolr is running"
touch lastcheck.txt
else
echo "ciasolr is not running, start it"
touch lasterror.txt
bundle exec puma -C config/puma.rb
fi

