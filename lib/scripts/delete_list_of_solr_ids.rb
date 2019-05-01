require 'yaml'
require 'rsolr'

y = YAML.load_file("../../config/solr.yml")
solr = RSolr.connect :url => y["url"]

type = "tms"

File.open('deletelist.txt').each_with_index do |line,index|
  index = index + 1
  id = "#{type}:#{line.strip}"
  output = "#{index.to_s}:  #{id}"
  puts output
  solr.delete_by_id id
end

solr.commit
