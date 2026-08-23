import pandas as pd
import requests

def column_rename(df):
    df = df.rename(columns={
    "address.city":"city",
    'company.name':"company_name"
    })
    final_data = df[["id","firstName","lastName","age","email","city","company_name"]]
    check_data(final_data)

def check_data(final_data):
    su = final_data.isna().sum()
    if su.sum() == 0:
        tocsv(final_data)
    else:
        print("null value occured")
        exit()

def tocsv(final_data):
        city_count = final_data.groupby("city")["id"].count().reset_index()
        name_sorting = final_data.sort_values(by="firstName")
        name_sorting.index = range(1, len(name_sorting) + 1)
        name_sorting.to_csv(r"/Users/srivathsan/Documents/Python Learning/Files/final_users.csv")

        with pd.ExcelWriter(r"/Users/srivathsan/Documents/Python Learning/Files/final_users.xlsx") as writer:
            name_sorting.to_excel(writer, sheet_name="users", index=False)
            city_count.to_excel(writer, sheet_name="city_count", index=False)

def check_code(url):
    response = requests.get(url)
    if (response.status_code == 200):
        print("success")
        data = response.json()["users"]
        df = pd.json_normalize(data)
        column_rename(df)
    else:
        print("fail")


url="https://dummyjson.com/users"
check_code(url)