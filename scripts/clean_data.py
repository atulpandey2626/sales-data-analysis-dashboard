import os
import pandas as pd

RAW_DATA_PATH = os.path.join("data", "raw_sales_data.xlsx")
CLEANED_DATA_PATH = os.path.join("data", "cleaned_sales_data.xlsx")

def clean_sales_data():
    print("Initializing Python Preprocessing Pipeline...")
    
    if not os.path.exists(RAW_DATA_PATH):
        print(f"Error: Source file not found at: {RAW_DATA_PATH}")
        print("Please ensure 'raw_sales_data.xlsx' is placed in the 'data/' directory.")
        return

    try:
        print("Loading raw sales records into Pandas Dataframe...")
        df = pd.read_excel(RAW_DATA_PATH, engine="openpyxl")
        
        initial_rows = len(df)
        print(f"Loaded {initial_rows} raw records.")

        print("Cleaning missing critical values and removing duplicates...")
        
        df = df.drop_duplicates()
        dedup_rows = len(df)
        if initial_rows - dedup_rows > 0:
            print(f"   Removed {initial_rows - dedup_rows} duplicate rows.")

        df['Quantity'] = df['Quantity'].fillna(0)
        df['Price_Per_Unit'] = df['Price_Per_Unit'].fillna(0.0)
        df['Discount'] = df['Discount'].fillna(0.0)
        
        df = df.dropna(subset=['Order_ID', 'Product_ID', 'Customer_ID', 'Order_Date'])

        print("Standardizing data types and parsing transaction schemas...")
        df['Order_ID'] = df['Order_ID'].astype(str)
        df['Product_ID'] = df['Product_ID'].astype(str)
        df['Customer_ID'] = df['Customer_ID'].astype(str)
        
        df['Order_Date'] = pd.to_datetime(df['Order_Date'], errors='coerce')
        df = df.dropna(subset=['Order_Date'])

        print("Calculating baseline revenue metrics...")
        df['Gross_Revenue'] = df['Quantity'] * df['Price_Per_Unit']
        df['Net_Revenue'] = df['Gross_Revenue'] - df['Discount']

        os.makedirs(os.path.dirname(CLEANED_DATA_PATH), exist_ok=True)
        
        print(f"Saving processed dataset ({len(df)} records) to destination...")
        df.to_excel(CLEANED_DATA_PATH, index=False, engine="openpyxl")
        print(f"Data processing complete! Target generated at: '{CLEANED_DATA_PATH}'")

    except Exception as e:
        print(f"Critical runtime failure during extraction: {str(e)}")

if __name__ == "__main__":
    clean_sales_data()
