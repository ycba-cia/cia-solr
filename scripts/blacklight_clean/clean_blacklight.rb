require 'rsolr'
solr_url1 = "http://10.5.96.187:8983/solr/ycba-collections_dev1"
solr_url2 = "https://user:6bELqBB8UTfl@ciaindex.britishart.yale.edu/solr/ycba_blacklight"

solr_conn1 = RSolr.connect :url => solr_url1
solr_conn2 = RSolr.connect :url => solr_url2

#uncomment to delete
#mode = "delete"

response = solr_conn1.post 'select', :params => {
          #:fq=>'object_type_s:"scan"',
          :fl=>'id,timestamp_dt,title_ss,author_ss,collection_ss',
          :sort=>'timestamp_dt asc',
          :start=>0,
          :rows=>1000,
          :fq=> "-timestamp_dt:[NOW-8DAY TO NOW]"
      }

docs = response['response']['docs']
if docs.length == 0
  puts "no items to clean"
  exit
else
  puts "number of documents to clean: #{docs.length}"
end

docs.each { |doc|
  id = doc["id"]
  puts "id:#{id}"
  if mode == "delete"
    solr_conn1.delete_by_id id
    solr_conn1.commit
    puts "deleted from solr_conn1: #{id}"
    solr_conn2.delete_by_id id
    solr_conn2.commit
    puts "deleted from solr_conn2: #{id}"
  end
}
