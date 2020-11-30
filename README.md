
# WORLD HAPPINESS REPORT
## Objective
I would like to explore the data related to the [World Happiness Report](https://worldhappiness.report/) through visualisations, on the following areas:
1. Is there an evolution of the Happiness Score over the period of 2015 – 2019 ?
2. Is “Economy” the most  decisive factor of the Happiness Score ?
3. Is the World Bank's "Income Share" index correlated with Happiness Score ?

## Methodology
1. Create a database from the available data
2. Exploit the database to produce visualisations and obtain answers to our queries.

## Tools

 - Data: [Kaggle](https://www.kaggle.com/unsdsn/world-happiness), [World Bank](https://datacatalog.worldbank.org/dataset/world-development-indicators)
 - Database: MySQL
 - Database editor: MySQL Workbench 8.0
 - Python: Jupyter Notebook, Pandas, Pymysql, SQLAlchemy
 - Data visualisation: Plotly
 - Web: Flask, Heroku

## Conceptual Data Model
![Conceptual Data Model](https://i.ibb.co/rkpzkWx/MCD.png)
 
 ## WHR_Create
 
 - Data fetch, cleaning & merge
 - Create a database from the results
 - Optimize the database:
	 - Optimize table data types.
	 - Set up the relations between the tables, and verify the constraints.
	 - Secure the database.
	 - Optimize the SQL queries.

## WHR_Exploit

Now that the data are ready, I can try to get some directions to the questions.
The steps are:
 - Injecting the tables into the dataframes (Pymysql &SQLAlchemy).
 - Produce the charts with Plotly.
 
**Note**: GitHub performs a static render of the notebooks and doesn't include the embedded HTML/JavaScript that makes up graphs. Please use this [link](
https://nbviewer.jupyter.org/github/huy75/WHR/blob/main/WH_Exploit.ipynb) to see the WHR_Exploit file with the interactive plotly charts.

## Answers
 - Is there an evolution of the Happiness Score over the period of 2015 – 2019 ? 
	 - *There have been no remarkable developments over the period in question*
 - Is “Economy” the most  decisive factor of the Happiness Score ?
	- *The most  decisive  factors are Economy & Health*
 
 - Is the World Bank's "Income Share" index correlated with Happiness Score ?
	 - *The index has no correlation with any of the factors making up the Happiness Score*
	 - *The happiest countries do not significantly  redistribute  their  wealth to the less  fortunate.*
