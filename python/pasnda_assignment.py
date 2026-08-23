import pandas as pd

df = pd.read_csv(r"/Users/srivathsan/Downloads/Data Eng/Python/day6_messy_employee_data.csv")
print(df.head(5))
print(df.shape)
print(df.isnull().sum())
print(df["salary"].isnull().sum())

df = df.fillna({
    "city" : "Unknown",
    "email" : "Not Provided",
    "dept" : "Not Assigned",
    "salary": df["salary"].mean()
})
print(df)
print("no.of duplicate", df.duplicated().sum())

df = df.drop_duplicates()

print("no.of new duplicate", df.duplicated().sum())

df = df.rename(columns={
    "emp_id" : "employee Id",
    "emp_name" : "employee name",
    "dept" : "department"
})

print(df)

mapping = {
    "IT" : "Information Technology",
    "HR" : "Human Resources",
    "Finance" : "Finance"
}

df["department"] = df["department"].map(mapping)

df["employee name"] = df["employee name"].map(str.upper)
print(df)

bonus = lambda salary : salary * 0.10

df["Bonus"] = df["salary"].apply(bonus)
print(df)

def salary_category(salary):
    if (salary >= 50000):
        return "High"
    else:
        return "Low"

df["salary category"] = df["salary"].apply(salary_category)


group = df.groupby("department")["salary"].mean()
print(group)

total_sal = df.groupby("department")["salary"].sum()
print(total_sal)

aggre = df.groupby("department")["salary"].agg(["min","max","mean"])
print(aggre)

employeecount = df.groupby("department")["employee Id"].count()
print(employeecount)

department_df = pd.DataFrame(
    {
        "department" : ["Information Technology","Human Resource","Finance"],
        "manager" : ["arun","sathish","rahul"],
        "location" : ["chennai", "mumbai", "kolkata"]

    }
)

merged_df = pd.merge(df,department_df,on="department")


print(merged_df[["employee name","department","salary","salary category","manager"]])



#Challenge Questions
#-------------------

highAvg = merged_df.groupby("department")["salary"].mean().idxmax()
print(highAvg)

merged_df["salary_after_bonus"] = merged_df["salary"] + (merged_df["salary"] * 0.10)

print(merged_df.groupby("department")["salary"].mean())

print(merged_df.groupby("department")["salary"].agg(["count","min","max","mean"]))