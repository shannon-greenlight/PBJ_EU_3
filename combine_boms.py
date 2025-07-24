import pandas as pd

# Read the CSV files
df1 = pd.read_csv('bom\\Digi-Key\\PBJ_EU_split.csv')
df2 = pd.read_csv('sub\\bom\\Digi-Key\\sub_split.csv')

target_col = 'Digi-Key Part #'

# Concatenate the dataframes
df = pd.concat([df1, df2])

# Group by 'part number' and sum the other columns
df = df.groupby(target_col, as_index=False).sum()

# Make 'part number' the last column
cols = list(df.columns)
cols = [col for col in cols if col != target_col] + [target_col]
df = df[cols]

# Write the result to a new CSV file
df.to_csv('bom/Digi-Key/PBJ_EU_combined.csv', index=False)