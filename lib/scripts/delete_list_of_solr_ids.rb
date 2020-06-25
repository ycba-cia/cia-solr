require 'yaml'
require 'rsolr'

#deprecated: get solr from yml file
#y = YAML.load_file("../../config/solr.yml")
#solr = RSolr.connect :url => y["url"]
#solr2 = RSolr.connect :url => y["url2"]

#tunnelling
#ssh -i "ycba-test.pem" -L 8983:10.5.96.78:8983 10.5.96.187 -l ec2-user

url = "http://10.5.96.187:8983/solr/ycba-collections_dev1"
url2 = "http://localhost:8983/solr/ycba_blacklight"

puts url
puts url2

solr = RSolr.connect :url => url
solr2 = RSolr.connect :url => url2

#type = "tms"
type = "orbis"
puts type

file = "/Users/ermadmix/Google Drive/ycba/cia/to_delete_jun25_2020.txt"

File.open(file).each_with_index do |line,index|
  index = index + 1
  #break if index > 2
  id = "#{type}:#{line.strip}"
  output = "#{index.to_s}:  #{id}"
  puts output
  solr.delete_by_id id
  solr2.delete_by_id id
end

solr.commit
solr2.commit
solr.optimize
solr2.optimize
