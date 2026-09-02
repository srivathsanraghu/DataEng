import pandas as pd
import json
import logging

logging.basicConfig(
    filename=r"/Users/srivathsan/Documents/Python Learning/Files/errorlogs.log",
    level = logging.INFO,
    format="%(asctime)s: %(levelname)s: %(message)s"
)


def getdata():

    with open (r"/Users/srivathsan/Documents/Python Learning/Files/employee.json","r") as file:
        data = json.load(file)
        logging.info("Reading JSON data")

    df = pd.json_normalize(data["employees"])

    return df


def employee_dataclean(df: pd.DataFrame):

    logging.info("Cleaning Employee data")

    df_employee = df[["employee_id","employee_name","gender","date_of_birth","email","phone","job_title","department",
                        "employment_type","hire_date","salary","performance_rating","years_experience","attendance_percentage",
                        "leave_days","overtime_hours","projects_completed","training_hours","manager.manager_id","office.office_id"]]

    duplicate_check = df_employee.duplicated().sum()
    if duplicate_check > 0:
        logging.info("Employee duplicate data found")
        df_employee = df_employee.drop_duplicates(subset="employee_id")
    
    df_employee = df_employee.rename(columns={
        "manager.manager_id" : "manager_id",
        "office.office_id" : "office_id",
        "attendance_percentage":"attendance",
        "overtime_hours":"overtime"
    })

    df_employee = df_employee.fillna({
        "employee_name":"Not fount",
        "email":"Not Given"
    })

    df_employee["date_of_birth"] = pd.to_datetime(df_employee["date_of_birth"], errors="coerce")
    df_employee["hire_date"] = pd.to_datetime(df_employee["hire_date"], errors="coerce")
    df_employee["overtime"] = df_employee["overtime"].clip(lower=0)
    df_employee["salary"] = pd.to_numeric(df_employee["salary"], errors="coerce")
    df_employee = df_employee.dropna(subset=["salary"])
    df_employee["attendance"] = df_employee["attendance"].clip(lower=0,upper=100)
    df_employee["leave_days"] = df_employee["leave_days"].abs()
    df_employee["projects_completed"] = df_employee["projects_completed"].clip(lower=0)

    df_employee["performance_rating"] = pd.to_numeric(df_employee["performance_rating"],errors="coerce")
    df_employee = df_employee[df_employee["performance_rating"].between(1, 5)]
    df_employee = df_employee.dropna(subset=["date_of_birth"])

    logging.info("cleaned employee data")

    return df_employee.reset_index(drop=True)

def manager_dataclean(df: pd.DataFrame):
    logging.info("Cleaning manager data")
    df_manager = df[["manager.manager_id","manager.manager_name","manager.manager_email","manager.manager_phone"
                    ,"manager.manager_title"]]

    df_manager = df_manager.rename(columns={
        "manager.manager_id":"manager_id",
        "manager.manager_name":"manager_name",
        "manager.manager_email":"manager_email",
        "manager.manager_phone":"manager_phone",
        "manager.manager_title":"manager_title"
    })

    duplicatecheck = df_manager.duplicated().sum()
    if duplicatecheck > 0:
        logging.info("Manager duplicate data found")
        df_manager = df_manager.drop_duplicates(subset="manager_id")

    df_manager = df_manager.fillna({
        "manager_name" : "Name not found",
        "manager_title" : "Title not found"
    })

    # ^ \(\rightarrow \) Start matching from the very beginning of the text.[a-zA-Z0-9._%+-]+ \(\rightarrow \) The username. Must be one or more letters, numbers, dots, underscores, percents, pluses, or dashes.@ \(\rightarrow \) Must have exactly one literal @ symbol.[a-zA-Z0-9.-]+ \(\rightarrow \) The domain name (e.g., gmail or 3m). Must be letters, numbers, dots, or dashes.\. \(\rightarrow \) Must have a literal dot right here.[a-zA-Z] \(\rightarrow \) The extension (like com, org, gov). Must be letters only.{2,} \(\rightarrow \) The extension must be at least 2 letters long.$ \(\rightarrow \) Stop checking. This must be the absolute end of the string.

    email_pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"

    df_manager = df_manager[df_manager["manager_email"].str.match(email_pattern, na=False)]
    logging.info("Cleaning manager data")
    return df_manager.reset_index(drop=True)
    

def office_dataclean(df: pd.DataFrame):

    logging.info("Cleaning office data")

    df_office = df[["office.office_id","office.office_name","office.address_line","office.city","office.state",
                    "office.country","office.postal_code","office.office_type"]]

    df_office = df_office.rename(columns=({
        "office.office_id":"office_id",
        "office.office_name":"office_name",
        "office.address_line":"address",
        "office.city":"city",
        "office.state":"state",
        "office.country":"country",
        "office.postal_code":"postal_code",
        "office.office_type":"office_type"
    }))

    duplicate_check = df_office.duplicated().sum()

    if duplicate_check > 0:
        logging.info("office duplicate data found")
        df_office = df_office.drop_duplicates(subset="office_id")
        
    df_office = df_office.dropna(subset=["office_id","address"])

    df_office = df_office.fillna({
        "city":"Not applicable",
        "country":"Not applicable",
        "office_type":"Not applicable",
        "state":"Not applicable"
    })

    df_office["postal_code"] = (
    df_office["postal_code"]
    .astype(str)
    .str.split(".")
    .str[0]
    .str.strip()
)

    df_office = df_office[
        df_office["postal_code"].str.match(r"^\d{6}$", na=False)
    ]
    logging.info("cleaned office data")
    return df_office.reset_index(drop=True)

def savefile(employee,manager,office):
    logging.info("Saving Excel file")
    with pd.ExcelWriter(r"/Users/srivathsan/Documents/Python Learning/Files/cleaned_data.xlsx") as writer:
        employee.to_excel(writer,sheet_name="Employee",index=False)
        manager.to_excel(writer,sheet_name="Manager",index=False)
        office.to_excel(writer,sheet_name="Office",index=False)

    # employee.to_csv(r"/Users/srivathsan/Documents/Python Learning/Files/cleaned_employee.csv")
    # manager.to_csv(r"/Users/srivathsan/Documents/Python Learning/Files/cleaned_manager.csv")
    # office.to_csv(r"/Users/srivathsan/Documents/Python Learning/Files/cleaned_office.csv")
    # logging.info("Process completed successfully")



def main():
    df = getdata()
    employee = employee_dataclean(df)
    manager = manager_dataclean(df)
    office = office_dataclean(df)

    savefile(employee,manager,office)

main()