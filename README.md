🎬 Netflix Movie Performance Analytics (2010–2025)

BigQuery + Grafana Cloud Dashboard
Created by: Madhukar Goli — MSBA, University of the Pacific

This repository contains an end-to-end analytics dashboard built using Google BigQuery and Grafana Cloud, providing deep insights into Netflix movie performance between 2010 and 2025.
It analyzes over 15,000+ movies, covering metrics such as ROI, popularity, genre trends, ratings, budget analysis, and global distribution.

This is part of my MSBA final project, showcasing skills in SQL, data visualization, cloud analytics, ETL, and dashboard development.

📊 Key Features
✔ 15 Interactive Grafana Panels

The dashboard includes:

Total Movies in Dataset

ROI Over Time (2010–2025)

Genre Distribution Analysis

Country-wise ROI Leaders

Movie Count by Country

Average Duration by Genre

Ratings Distribution

Release Trend Over Years

ROI vs Popularity & Vote Count (Scatter Plot)

Top 10 Highest Rated Movies

Language Distribution

Age Rating Distribution

Movie Runtime Patterns

Global ROI Efficiency Buckets

High-Budget vs High-Revenue Titles (Scatter)

Each panel uses optimized BigQuery SQL queries and interactive Grafana visualizations.

🛠️ Tech Stack
Backend / Data

Google BigQuery (SQL engine + dataset hosting)

GCP Storage / Service Accounts

BigQuery SQL (CTEs, aggregations, UNNEST, time-series)

Visualization

Grafana Cloud (Free tier)

XY visualizations

Bar charts

Time series

Stat panels

Bubble/Scatter charts

Other Tools

VS Code

Git & GitHub

CSV preprocessing and schema creation

JSON dashboard modeling

📁 Repository Structure
netflix-analytics-dashboard/
│
├── README.md                    → Documentation (this file)
├── .gitignore                   → Protects keys & private files
│
├── grafana/
│   └── netflix_dashboard_model.json
│        → Exported Grafana dashboard (importable)
│
├── bigquery/
│   ├── panel_queries.sql        → SQL for all 15 dashboard panels
│   └── table_schema.json        → BigQuery table schema
│
├── data/                        → (Optional) Dataset used
│   └── Netflix_Analysis_2010_2025_Updated.csv
│
└── screenshots/                 → Visual previews of each panel
    ├── panel01.png
    ├── panel02.png
    ├── ...

📦 Dataset Description

The BigQuery public table includes:

Title

Type (Movie / Show)

Genres

Country

Language

Director / Cast

Date Added to Netflix

Release Year

Rating / Vote Count / Popularity

Budget / Revenue / Profit

ROI = Profit ÷ Budget

Schema file:
bigquery/table_schema.json

SQL for all 15 panels:
bigquery/panel_queries.sql

🚀 How to Import the Dashboard (Grafana)

Open Grafana Cloud

Go to Dashboards → New → Import

Upload the JSON file:

grafana/netflix_dashboard_model.json


Select your BigQuery data source

Dashboard loads automatically

🔥 Insights Uncovered

Dramatic ROI differences across regions

Genre behavior changes over time

Impact of popularity and vote count on ROI

Rise of foreign-language titles

Budget vs revenue patterns

Genre duration and performance relationships

🧠 Skills Demonstrated
Data Engineering

Cloud data ingestion

BigQuery table creation

Schema design (JSON)

Dataset cleaning + transformation

Data Analytics

Time-series analysis

Aggregations, CTEs, UNNEST

ROI calculations

Popularity vs financial performance

Data Visualization

Grafana query builder + transformations

XY/scatter plots

KPI/Stat panel design

Interactive filtering and drilldowns

Cloud Architecture

Grafana Cloud integration

BigQuery authentication using service accounts

Multi-dataset dashboard configuration

🧑‍💻 Author

Madhukar Goli
📍 MSBA Graduate Student, University of the Pacific
📊 Data Analyst | SQL | BigQuery | Python | Cloud Analytics
🔗 LinkedIn: (Add your link here)
