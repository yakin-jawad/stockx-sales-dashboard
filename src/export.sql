copy (SELECT * FROM data.staging_table)
to '/stockx-sales-dashboard/data/cleaned_dataset.csv'
with CSV HEADER;