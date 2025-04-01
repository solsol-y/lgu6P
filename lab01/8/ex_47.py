import pandas as pd
pd.read_excel
df= pd.read_excel("./data/scores.xlsx")
print(df)
df = df.T. to_dict()
data = [v for k, v in df.items]
print(data)