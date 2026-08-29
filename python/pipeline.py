import pandas as pd
import requests
import logging
import json

logging.basicConfig(
    filename="errorlogs.log",
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

def get_api_data():

    try:
        with open("config.json") as f:
            config = json.load(f)
            logging.info("URL imported")

        response = requests.get(config["url"])
        if (response.status_code == 200):

            logging.info("URL Reached")
            data = response.json()["users"]
            return data
        else:
            logging.error("URL not reachable")
    except Exception as e:
     logging.error("error occurred: %s", e)

def normalize_and_transform(data):
        try:
            df = pd.json_normalize(data)
            logging.info("Data normalized")
            df = df.rename(columns={
                "address.city":"city",
                'company.name':"company_name"
                })
            final_data = df[["id","firstName","lastName","age","email","city","company_name"]]
            logging.info("Columns renamed")
            su = final_data.isna().sum()

            if su.sum() == 0:
                logging.info("null not exist in data frame")
            else:
                logging.info("null exist in data frame")
            return final_data
        except Exception as e:
                logging.error("data missing %s",e)
             
def clean_data(final_data):
            try:
                final_data = final_data.fillna({
                    "firstName":"Not found",
                    "lastName":"Not found",
                    "age":0,
                    "email":"Not found",
                    "city":"Not found",
                    "company_name":"Not found"
                })
                logging.info("cleaned the null values")

                return final_data

            except Exception as e:
                logging.error("data missing %s",e)

def create_outputs(final_data):
        try:
            name_sorting = final_data.sort_values(by="firstName")
            name_sorting.index = range(1, len(name_sorting) + 1)
            return name_sorting
        except Exception as e:
            logging.error("not able to write the file %s",e)

def save_files(name_sorting):
            try:
                name_sorting.to_csv(r"/Users/srivathsan/Documents/Python Learning/Files/final_users.csv")
                logging.info("File saved.")
                logging.info("Program completed")   
            except Exception as e:
                logging.error("File not able to write %s",e)
            exit()

def main():
    data = get_api_data()
    final_data = normalize_and_transform(data)
    final_data = clean_data(final_data)
    name_sorting = create_outputs(final_data)
    save_files(name_sorting)

main()