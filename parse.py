import pandas as pd
import numpy as np


borders=[n for n,row in df2.iterrows() if row.isna().all()]
null_row=df2.iloc[borders[0]].copy()
reconstitutor_for_dataframe=[]
pruebas=[]
for n,node in enumerate(borders):
  df_slice=df2.iloc[borders[n-1]+1:node,:]
  df_slice[1:]['Names']=['' for i in range(df_slice[1:]['Name'].shape[0])]
  pruebas.append(df_slice)
  # if not df_slice.empty:
    # print(df_slice.iloc[0,:]['Unnamed: 0'])
  for n, row in df.iterrows():
    if row.name.lower() in ' '.join(df_slice["Unnamed: 0"].dropna().str.lower()):
      sel=df_slice.iloc[-1,:].copy()
      for italian_name in row.dropna():
        sel['Unnamed: 0']=italian_name
        df_slice=df_slice.append(sel)
        break
  df_slice=df_slice.append(null_row)
  reconstitutor_for_dataframe.append(df_slice)


  