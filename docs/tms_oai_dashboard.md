Use the following plan to add a new controller "tms_harvester_controller.rb" with views.
It should create a dashboard based on the metadata_record table in the tms_serialization.db sqlite3 database.

The dashboard should have 2 tabs.

tab 1. Counts:
1. "select count(*) from metadata_record" for each "status" 
tab 2. List:
1. Create a dropdown for each "status" in metadata_record (create,same,update,stale)
2. Below the status dropdown create a grid of 15 rows with pagination for the sql "select local_identifer,created_at,updated_at from metadata_record where status = status
3. Make each column header of the grid sortable where local_identifier is an integer and created_at and updated_at are timestamps

Use playwrite mcp to propose a browser layout to assess how it looks

Modification 1:
In the html table in index.html.erb list tab hyperlink the values in the local_identifier column to the URL in the harvesterLink field in connections.yml substituting ID with the local identifier

Modification 2: 
1. modify tms_harvester_controller select the diff column in the metadata_records query
2. In the html table in index.html.erb list tab add a column called "Diff". When diff is not null display "open diff" in that column and open up a new browser tab with the contents of that field formatted and aligned

