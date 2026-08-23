import numpy as np
import pandas as pd
import json
import requests
# Part A - Python Basics & Functions
# ----------------------------------------------------------------
def evenorodd(number):
    if number%2==0:
        print("Entered number is Even")
    else:
        print("Entered number is ODD")

# number = int(input("Enter the number: "))
# evenorodd(number)

students = [
    {"name":"Raj","mark":50},
    {"name":"Ravi","mark":50},
    {"name":"Rahul","mark":80}
]

def passorfail(students):
    for student in students:
        if(student["mark"]>=50):
            print(student["name"], "is pass")
        else:
            print(student["name"],"is fail")

# passorfail(students)


# number = int(input('Enter the number: '))
square = lambda number : number * number
# print(square(number))


# Part B - Lists & Dictionaries
# ----------------------------------------------------------------

marks = [75, 82, 60, 91, 55]
stu = np.array(marks)
# print(stu.max())
# print(stu.min())
# print(stu.sum())
# print(stu.mean())


students = [
    {"name":"Raj","age" : 25, "course" : "data engineering", "city":"chennai"},
    {"name":"Ravi","age" : 32, "course" : "data Analyst", "city":"tirupur"},
    {"name":"Rahul","age" : 33, "course" : "data science", "city":"coimbatore"}
]

# for student in students:
    # print(student["name"])

students[0]["emailid"] = "raj@gmail.com"
students[1]["emailid"] = "ravi@gmail.com"
students[2]["emailid"] = "rahul@gmail.com"

students[0].update({"city" : "kolkata"})

# for student in students:
#     for key,values in student.items():
#         print(key)
#         print(values)
#         print(student.items())
#     print(student.keys())


#Part C - NumPy
# ----------------------------------------------------------------

a = [10, 20, 30, 40, 50]
b = np.array(a)

# print(b)
# print(type(b))
# print(b[0])
# print(b[-1])
# print(b[1:4])

arr = np.array([10, 20, 30, 40, 50])
mul_arr = arr*2
# print(mul_arr)
# print(mul_arr.sum())
# print(mul_arr.mean())
# print(mul_arr.min())
# print(mul_arr.max())


arr = np.array([10, 25, 30, 45, 50, 65, 70])
n=[]
for i in arr:
    if i>40:
        n.append(i)

# print(np.array(n))

#2. result on diff
result = arr[arr > 40]
# print(result)




emp1 = [{
    "employee_id": [101, 102, 103, 104, 105, 106],
    "name": ["Arun", "Priya", "Kumar", "Divya", "Rahul", "Sneha"],
    "department":["IT", "HR", "IT", "Finance", "HR", "IT"],
    "salary": [50000, 45000, 60000, 55000, 48000, 65000],
    "experience": [2, 3, 5, 4, 2, 6]
}]
df = pd.DataFrame(emp1[0])
# print(df)
# print(df.head(3))
# print(df.tail(2))
# print(df.columns)
# print(type(df))
# print(df.describe()[["salary", "experience"]])

# print(df[["name","salary"]])
# print(df.iloc[0])
# print(df.loc[:,"name"])

# print(df[df["salary"]>50000])
# print(df[df["department"]=='IT'])
# print(df[
#     (df["department"]=='IT') & 
#     (df["salary"]>50000)
#     ])

empl = [
    {
        "name": ["Arun", "Priya", "Kumar", "Divya"],
        "city": ["Chennai", None, "Bangalore", None],
        "salary": [50000, 45000, None, 55000]
    }
]

df = pd.DataFrame(empl[0])
df["city"] = df["city"].fillna("unknown")
df["salary"] = df["salary"].fillna(df["salary"].mean())
# print(df)

emp = [{
    "emp_id": [101, 102, 102, 103, 104, 104],
    "emp_name": ["Arun", "Priya", "Priya", "Kumar", "Divya", "Divya"]
}]

df = pd.DataFrame(emp[0])
# print(df.duplicated().sum())
df = df.drop_duplicates()
df = df.rename(columns={
"emp_id": "employee_id",
"emp_name":"employee_name"
})
# print(df)


employee = pd.DataFrame(emp1[0])
# print(employee)
Average_salary = employee.groupby("department")["salary"].mean()
max_salary = employee.groupby("department")["salary"].max()
count = employee.groupby("department")["employee_id"].count()

# print(Average_salary)
# print(max_salary)
# print(count)


#merge

employee = [{
    "emp_id" : [101,102,103,104], 
    "name" : ["Arun","Priya","Kumar","Divya"], 
    "dept_id" : [1,2,1,3]
}]

Department = [{ 
    "dept_id" : [1,2,3], 
    "department" : ["IT","HR","Finance"]
}]


empl_df = pd.DataFrame(employee[0])
dept_df = pd.DataFrame(Department[0])

mergedf = pd.merge(empl_df,dept_df,"inner",on="dept_id")
# print(mergedf[["emp_id","name","department"]])

#Part G - File Handling & JSON
# -----------------------------------------------------

tocsv = pd.DataFrame(emp1[0])
tocsv.to_csv(r"/Users/srivathsan/Documents/Python Learning/Files/sample_employee.csv")

sample_csv = pd.read_csv(r"/Users/srivathsan/Documents/Python Learning/Files/sample_employee.csv")
# print(sample_csv.head(5))



student = {
    "name":"Raj",
    "age":25,
    "course":"python"
}

with open (r"/Users/srivathsan/Documents/Python Learning/Files/student.json","w") as file:
    data = json.dump(student,file,indent=4)

with open (r"/Users/srivathsan/Documents/Python Learning/Files/student.json","r") as file:
    data = json.load(file)
    # print(data)


A = {"name": "Arun", "age": 25}
B = [{"name": "Arun", "age": 25}, {"name": "Priya", "age": 24}]

# print(type(A))
# print(type(B))

# print(pd.DataFrame([A]))
# print(pd.DataFrame(B))

#A is a single dictionary values. which is not converted directly to dataframe. to convert we need to pass the A in list.
#B is a list of dictionaries where each dictionary represents a rows, so B can be directly converted into a DataFrame.


#Part H - API
#-----------------------------------------



url="https://dummyjson.com/users"

code = requests.get(url)
# print(code.status_code)
data = code.json()
# print(type(data))
df = pd.json_normalize(data["users"])
# print(df.keys())
# print(df)
# print(df.head(1))

df = df.rename(columns={
    "address.address":"address",
    "address.city":"city",
    "address.state":"state",
    "address.stateCode":"stateCode",
    'address.postalCode':"postalcode", 
    'address.coordinates.lat':"address_latitude",
    'address.coordinates.lng':"address_longitude", 
    'address.country':"country", 
    'bank.cardExpire':"cardEcpire",
    'bank.cardNumber':"cardnumber", 
    'bank.cardType':"cardtype", 
    'bank.currency':"currency", 
    'bank.iban':"iban",
    'company.department':"department", 
    'company.name':"company_name", 
    'company.title':"company_title",
    'company.address.address':"company_address", 
    'company.address.city':"company_city",
    'company.address.state':"company_state", 
    'company.address.stateCode':"company_statecode",
    'company.address.postalCode':"company_postalcode", 
    'company.address.coordinates.lat':"company_latitude",
    'company.address.coordinates.lng':"company_longitude", 
    'company.address.country':"company_country",
    'crypto.coin':"crypto_coins", 
    'crypto.wallet':"crypto_wallet",
    'crypto.network':"crypto_network"
})


# print(df)
# print(df.keys())

csvfile = df[["id","firstName","lastName","age","email","city","company_name"]]
# print(csvfile)
csvfile.to_csv(r"/Users/srivathsan/Documents/Python Learning/Files/dummpy_clean.csv")