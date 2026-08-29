import pandas as pd
import requests
import logging
import json

logging.basicConfig(
    filename="errorlogs.log",
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

try:
    with open("config.json") as f:
        config = json.load(f)
        logging.info("URL imported")

    response = requests.get(config["url"])
    if (response.status_code == 200):

        logging.info("URL Reached")
        data = response.json()["users"]

        df = pd.json_normalize(data)
        logging.info("Data normalized")

        df = df.rename(columns={
            "address.city":"city",
            'company.name':"company_name"
            })
        final_data = df[["id","firstName","lastName","age","email","city","company_name"]]
        logging.info("Columns renamed")

        final_data = final_data.fillna({
                "firstName":"Not found",
                "lastName":"Not found",
                "age":0,
                "email":"Not found",
                "city":"Not found",
                "company_name":"Not found"
            })
        logging.info("cleaned the null values and program started")

        su = final_data.isna().sum()

        if su.sum() == 0:
            logging.info("null not exist in data frame")
            city_count = final_data.groupby("city")["id"].count().reset_index()
            name_sorting = final_data.sort_values(by="firstName")
            name_sorting.index = range(1, len(name_sorting) + 1)
            name_sorting.to_csv(r"/Users/srivathsan/Documents/Python Learning/Files/final_users.csv")
            
            with pd.ExcelWriter(r"/Users/srivathsan/Documents/Python Learning/Files/final_users.xlsx") as writer:
                    name_sorting.to_excel(writer, sheet_name="users", index=False)
                    city_count.to_excel(writer, sheet_name="city_count", index=False)
                    logging.info("File saved.")
                    logging.info("Program completed")
        else:
            logging.info("null exist in data frame")
    else:
        logging.error("URL failed")
except FileNotFoundError:
    logging.error("File not found")
    exit()
except Exception as e:
     logging.error("error occurred: %s", e)
