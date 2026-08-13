Use the following plan to update the home controller and views

In home/index.html.erb at the bottom add a new form.
The form will consist of an html select dropdown called "collection" with the following values:
- Prints and Drawings
- Reference Library
- Rare Books and Manuscripts
- Archives
- Paintings and Sculpture
- Frames
- Artists

The form will have a hidden field called "yesterday" with yesterday's timestamp in the form of yyyy-mm-ddT00:00:00.000Z

The form will trigger an action that calls a delete_lookup method to be added to the home controller.
It will query @solr2 with an fq field using form fields like:
"fq":"collection_ss:\"#{collection}\" && timestamp_dt:[* TO #{yesterday}]",

The solr query will return field list fl with id,locnaf_ss,timestamp_dt when collection="Artists"
and id, title_ss,author_ss, timestamp_dt for all other collections

With the solr should be outputted to a table added below the collection form in home/index.html.erb.
The table should show 15 rows and scroll vertically for more.
