import pandas as pd  # Исправлено здесь
from sqlalchemy import create_engine  

csv_file_path = 'C:/Users/nmada/Desktop/sql/music.csv' 
df = pd.read_csv(csv_file_path) 

df['time'] = df['time'].str.replace(',', '.').astype(float)

df = df.fillna('Nah') 

engine = create_engine('postgresql+psycopg2://postgres:engelsa65@localhost:5432/postgres') 

df.columns = df.columns.str.strip()

df.to_sql('raw_data', engine, if_exists='replace', index=False) 
print("Data loaded successfully into PostgreSQL.")
