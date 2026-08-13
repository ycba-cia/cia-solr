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

