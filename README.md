# Housing Data Cleaning Project using SQL

## Project Description

This project demonstrates advanced SQL skills in cleaning and preparing a housing dataset for analysis. Using a complex dataset containing various property details, I performed thorough data cleaning operations to improve data quality and consistency.

## Key Features

1. Standardizing date formats for consistency
2. Populating missing property addresses using self-joins
3. Breaking down complex address fields into individual columns (address, city, state)
4. Standardizing categorical data (e.g., 'Y' and 'N' to 'Yes' and 'No')
5. Removing duplicate records using window functions
6. Deleting unused columns to optimize the dataset

## Skills Demonstrated

- Data type conversion
- Self-joins for data population
- String manipulation (SUBSTRING, CHARINDEX, PARSENAME)
- Handling NULL values
- Case statements
- Window functions (ROW_NUMBER)
- Table alterations (adding and dropping columns)

## Project Highlights

This data cleaning project showcases the ability to transform raw, messy data into a clean, analysis-ready dataset, which is a crucial skill in data analysis and database management.

## File Structure

- `SQLQuery2.sql`: Main SQL file containing all data cleaning operations

## How to Use

1. Clone this repository
2. Ensure you have access to a SQL database with the housing dataset
3. Run the queries in `SQLQuery2.sql` to clean and prepare the data

## Cleaning Operations Performed

- Standardized date format
- Populated missing property addresses
- Split property addresses into separate columns for address, city, and state
- Split owner addresses into separate columns
- Standardized 'Sold as Vacant' field values
- Removed duplicate records
- Deleted unused columns

## Future Improvements

- Implement more advanced data validation checks
- Create views of the cleaned data for easier querying
- Develop a data quality report to summarize the cleaning process
