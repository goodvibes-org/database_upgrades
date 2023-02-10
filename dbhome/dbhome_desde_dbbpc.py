# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
#%% Definiciones y demsases
import pandas as pd

FILENAME = "BPC_Ingredientes_ALL_borrador_updated_non_harm.xlsx"
FILENAME_INGREDIENTES_FULL = "BPC_Ingredientes.xlsx"

compname = 'Name to Compare "Tool" (Risk databases)'
# %% Remover cancer annotations


df = pd.read_excel(FILENAME)

all_descriptions = df["Info para Reporte"].dropna().apply(lambda x : x.split("."))
all_nodes = []
for node in all_descriptions:
    all_nodes += node
all_descriptions = set(all_nodes)


cancer_descriptions = {desc for desc in all_descriptions if 'cancer' in desc.lower()}

df["mezza_column"] = df["Info para Reporte"].apply(
    lambda x : x.split(".") if type(x) == str else x 
    )
metanodes = []
for n, row in df.dropna(subset = 'mezza_column').iterrows():
    nodes_to_keep = []
    for node in df.loc[n, 'mezza_column']:
        if node not in cancer_descriptions:
            nodes_to_keep.append(node)
            metanodes.append(nodes_to_keep)
    df.loc[n, 'mezza_column'] = ".".join(nodes_to_keep)
    



all_descriptions = df["mezza_column"].dropna().apply(lambda x : x.split("."))
all_nodes = []
for node in all_descriptions:
    all_nodes += node
all_descriptions = set(all_nodes)


cancer_descriptions = {desc for desc in all_descriptions if 'cancer' in desc.lower()}


print(len(cancer_descriptions))

#%% Scores Cancer

replacements = 0 


def get_cancer_score(name : str, replacements: int) -> float:
    try:
        replacements += 1
        cond = ingredientes_full[compname] == name
        rv = ingredientes_full["Cancer.Risk"][cond].values[0] 
    except IndexError:
        rv = 0 
    return rv, replacements




ingredientes_full = pd.read_excel(FILENAME_INGREDIENTES_FULL)
test = df.copy(deep = True)
for n, node in df.iterrows():
    fct, rpl = get_cancer_score(node[compname], replacements)
    fct *= .6
    test.loc[n,"Total.Risk"] -= fct

test["Info para Reporte"] = test.mezza_column
test.drop("mezza_column", axis = 1, inplace = True)
test.to_excel("bpc_home.xlsx")