# 📦 Amazon Sales Analysis — End-to-End Business Intelligence Project

> A complete, multi-tool business analysis pipeline built from raw data to interactive dashboard — spanning PostgreSQL, Excel, Power Query, Pivot Tables, and Power BI.

\---

## 📌 Project Overview

This project delivers a full end-to-end sales analysis of an Amazon dataset sourced from Kaggle (2025, 250 rows). The goal was to transform raw transactional data into structured, insight-ready tables and ultimately into an interactive Power BI dashboard — enabling business stakeholders to explore sales performance by customer, product, category, and payment method with ease.

\---

## 🛠️ Tools \& Technologies Used

|Tool|Purpose|
|-|-|
|**Kaggle**|Data source (raw Amazon sales dataset)|
|**PostgreSQL**|Database creation, data modeling, SQL querying|
|**PowerShell**|Dataset import into PostgreSQL|
|**Excel**|Fact table construction, data transformation|
|**Power Query**|Data cleaning, column derivation, type formatting|
|**Pivot Tables \& Pivot Charts**|Aggregated insights and visual exploration|
|**Power BI**|Interactive KPI dashboard with slicers and visuals|

\---

## 🗂️ Project Workflow

### Step 1 — Data Acquisition

* Downloaded a **2025 Amazon Sales dataset** from Kaggle containing **250 rows** of raw transactional data.

\---

### Step 2 — Database Setup in PostgreSQL

* Imported the raw dataset into **PostgreSQL** using **PowerShell queries**.
* Created a database named **`amazon`**.
* Loaded the raw data into a table named **`amazonori`** (the original/raw table).

\---

### Step 3 — Data Modeling: Star Schema Design

Decomposed the raw table into **4 structured sub-tables** following a star schema pattern:

|Table|Key Columns|
|-|-|
|**Orders** ⭐ *(Central / Fact-linking table)*|`order\_id`, `customer\_name`, `product`|
|**Customers**|`customer\_name`, `customer\_id` *(newly added)*|
|**Products**|`product`|
|**Payment Methods**|`order\_id`, `payment\_method`|

* The **Orders** table served as the **central link (star) table**, holding foreign key relationships with all three dimension tables.
* A new **`customer\_id`** column was created in the Customers table to establish a proper primary key.

\---

### Step 4 — Fact Table Creation (SQL)

* Constructed a **master Fact Table** by writing an **INNER JOIN** query across all four sub-tables:

```sql
  SELECT DISTINCT o.\*, c.customer\_id, p.\*, pm.\*
  FROM orders AS o
  INNER JOIN customers AS c ON o.customer\_name = c.customer\_name
  INNER JOIN products AS p ON o.product = p.product
  INNER JOIN payment\_methods AS pm ON o.order\_id = pm.order\_id;
  ```

* The fact table consolidated all essential columns required for downstream analysis.

\---

### Step 5 — SQL Analysis \& Querying

Wrote a range of SQL queries to extract key business metrics, including:

* **Average Order Value** — by customer, product, and payment method
* **Revenue Analysis** — by customer, product, and category
* **Order Count \& Max Order per Customer** — sorted in descending order
* **String Operations** — `CONCAT`, `SUBSTRING` for customer name manipulation
* **Segmentation** — `CASE WHEN` logic applied to create customer/product/category value tiers:

```sql
  CASE
      WHEN SUM("total\_sales") >= 25000 THEN 'High Value'
      WHEN SUM("total\_sales") >= 10000 THEN 'Medium Value'
      ELSE 'Low Value'
  END AS segment
  ```

\---

### Step 6 — Metrics Tables (Derived from Fact Table)

Created three dedicated **metrics/segment tables** from the fact table:

|Metrics Table|Segment Logic|
|-|-|
|**Customer Metrics**|Segmented by total sales per customer|
|**Product Metrics**|Segmented by total sales per product|
|**Category Metrics**|Segmented by total sales per category|

Each metrics table includes a **`segment`** column (`High Value` / `Medium Value` / `Low Value`) derived using `CASE WHEN` statements.

\---

### Step 7 — Export to Excel \& Power Query Transformations

Exported all tables (Fact Table + 3 Metrics Tables) from PostgreSQL to Excel, then performed the following **Power Query** transformations:

**On the Fact Table:**

* Added a **`Year-Month`** column for time-series analysis
* Added a **`Payment Type`** column
* Changed data types of `Avg Order Size` and `Total Sales` to **Currency**
* **Split customer full names** into `First Name` and `Surname` columns

**On the Metrics Tables:**

* Added **customer-wise percentage share** column
* Applied consistent data type formatting across all tables

\---

### Step 8 — Pivot Tables \& Pivot Charts (Excel)

* Created **Pivot Tables** and **Pivot Charts** from the transformed metrics tables
* Added **Slicers** for dynamic, interactive filtering
* Built **Pie Charts** for percentage-based visual breakdowns

\---

### Step 9 — Power BI Dashboard

Loaded all transformed metrics tables into **Power BI** and built an interactive dashboard featuring:

**Slicers (5):**

* Category
* Customer
* Payment Method
* Product Segment
* Year-Month

**Visualizations:**

* 📊 **Amazon Sales Column Chart** — Sales (Y-axis) vs. Year-Month (X-axis)
* 🥧 **Customer Percentage Pie Chart** — Share of sales by customer
* 🥧 **Product Percentage Pie Chart** — Share of sales by product
* 📊 **Payment Method Breakdown** — Horizontal 2D bar chart (Payment Methods on Y-axis, Sales on X-axis)
* 💬 **Q\&A Input Box** — Natural language querying of the dashboard
* 🔍 **Key Influencers Visual** — AI-powered driver analysis

\---

## 📊 Key Insights Enabled

* Identify **high, medium, and low value** customers, products, and categories at a glance
* Track **revenue trends over time** using the Year-Month axis
* Understand **payment method preferences** and their sales contribution
* Drill into any **specific customer, category, or segment** using slicers
* Use the **Q\&A box** for ad-hoc natural language queries on the data

\---

## 📁 Repository Structure

```
amazon-sales-analysis/
│
├── data/
│   └── amazonori.csv                  # Raw Kaggle dataset
│
├── sql/
│   ├── create\_tables.sql              # Sub-table creation scripts
│   ├── fact\_table.sql                 # Fact table JOIN query
│   ├── analysis\_queries.sql           # KPI and metric queries
│   └── metrics\_tables.sql             # Segment table creation
│
├── excel/
│   ├── fact\_table.xlsx                # Exported fact table
│   ├── customer\_metrics.xlsx          # Customer metrics + segments
│   ├── product\_metrics.xlsx           # Product metrics + segments
│   └── category\_metrics.xlsx          # Category metrics + segments
│
├── power\_bi/
│   └── amazon\_sales\_dashboard.pbix    # Power BI dashboard file
│
└── README.md
```

\---

## 🚀 How to Reproduce This Project

1. **Download** the Amazon Sales dataset from Kaggle.
2. **Import** the CSV into PostgreSQL using PowerShell/SQL scripts or direct import functionality available on PostgreSQL.
3. **Run** the SQL scripts in order: `create\_tables.sql` → `fact\_table.sql` → `analysis\_queries.sql` → `metrics\_tables.sql`.
4. **Export** all output tables to Excel.
5. **Open** the Excel files and apply Power Query transformations as documented.
6. **Load** the transformed tables into Power BI and open `amazon\_sales\_dashboard.pbix`.

\---

## 👤 Author

**\[Tanay Bhosale]**  
Turning Raw Data into Business Insights

Business \& Data Analysis | SQL | Excel | Power BI 
📧 \[bhosaletanay07@gmail.com]  
🔗 \[www.linkedin.com/in/tanay-bhosale-388bb72b7]  
💻 \[https://github.com/Tanay77/Amazon-Sales-Analysis/upload/main]

\---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).

\---

*If you found this project useful or insightful, feel free to ⭐ star the repository and connect with me on LinkedIn!*

