# Redshift-warehouse-simulation
Step-by-step simulation of a data warehouse in AWS Redshift, as well as some scripts that generate some insights about the database

## General Structure
This repository is comprised of two folders:
- Databases: general overview of the data used in a csv format
- sql_scripts: Scripts used to structure and create reports using AWS redshift

## Requirements
- An AWS account
- The creation of a bucket to store the csv files
- A cluster in redshift (free-tier configuration)


## <b> Attention! </b>
The scripts need to be executed at the right order (the credentials will need to be replaced):
1) create_tables.sql
2) copy_data_from_bucket.sql 
3) analysis


