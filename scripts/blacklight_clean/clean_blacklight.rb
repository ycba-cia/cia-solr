require 'rsolr'
require 'yaml'

y = YAML.load_file("../../config/solr.yml")

solr_url1 = y["url"]
#solr_url2 = "https://user:****@ciaindex.britishart.yale.edu/solr/ycba_blacklight"

solr_conn1 = RSolr.connect :url => solr_url1
#solr_conn2 = RSolr.connect :url => solr_url2

#configuration variables
output = ""
output = "list"
mode = ""
#mode = "delete"


fq = 'collection_ss:"Reference Library" && timestamp_dt:[* TO NOW-1DAY]'
#fq = 'collection_ss:"Rare Books and Manuscripts" && timestamp_dt:[* TO NOW-1DAY]'
response = solr_conn1.post 'select', :params => {
          :fq =>fq,
          :fl=>'id,timestamp_dt,title_ss,author_ss,collection_ss',
          :sort=>'timestamp_dt desc',
          :start=>0,
          :rows=>200000
      }

docs = response['response']['docs']
puts "fq:#{fq}"
if docs.length == 0
  puts "no items to clean"
  exit
else
  puts "number of documents to clean: #{docs.length}"
  puts ""
  if output == "list"
    docs.each_with_index { |doc, i|
      #break if i > 10
      puts doc["title_ss"]
      puts doc["id"]
      puts doc["timestamp_dt"]
      puts ""
    }
  end
end

#exit

docs.each { |doc|
  id = doc["id"]
  puts "id:#{id}"
  if mode == "delete"
    solr_conn1.delete_by_id id
    solr_conn1.commit
    puts "deleted from solr_conn1: #{id}"
    #solr_conn2.delete_by_id id
    #solr_conn2.commit
    #puts "deleted from solr_conn2: #{id}"
  end
}
