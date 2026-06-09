import pandas as pd
import matplotlib.pyplot as plt

# Load data
df = pd.read_excel(r"G:\Data Analytics\Power BI\Coffee+Shop+Sales\Coffee Shop Sales.xlsx")

# Basic exploration
print(df.shape)
print(df.head())
print(df.info())
print(df.describe())

# Add revenue column
df['revenue'] = df['transaction_qty'] * df['unit_price']

# Total revenue
print("Total Revenue:", df['revenue'].sum())

# Revenue by product category
category_sales = df.groupby('product_category')['revenue'].sum().sort_values(ascending=False)
print(category_sales)

# Revenue by store location
location_sales = df.groupby('store_location')['revenue'].sum().sort_values(ascending=False)
print(location_sales)

# Top 5 products
top_products = df.groupby('product_detail')['revenue'].sum().sort_values(ascending=False).head(5)
print(top_products)

# Bar chart - revenue by category
category_sales.plot(kind='bar', title='Revenue by Product Category', color='brown')
plt.ylabel('Revenue')
plt.tight_layout()
plt.savefig('revenue_by_category.png')
plt.show()

# Bar chart - revenue by location
location_sales.plot(kind='bar', title='Revenue by Store Location', color='teal')
plt.ylabel('Revenue')
plt.tight_layout()
plt.savefig('revenue_by_location.png')
plt.show()