-- For ease of access, just run these commands in the terminal to build and clean the database.
psql stockx_dataset < /stockx-sales-dashboard/src/import.sql
psql stockx_dataset < /stockx-sales-dashboard/src/cleaning.sql
psql stockx_dataset -f /stockx-sales-dashboard/src/export.sql