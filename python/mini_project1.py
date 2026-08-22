employees = [
    {"id": 101, "name": "Raj", "age": 30, "salary": 50000},
    {"id": 102, "name": "Sri", "age": 33, "salary": 65000},
    {"id": 103, "name": "Arun", "age": 28, "salary": 45000},
    {"id": 104, "name": "Priya", "age": 31, "salary": 70000},
    {"id": 105, "name": "Kumar", "age": 35, "salary": 55000}
]

def display_employee(employees):
    for emp in employees:
        print(emp)

def calculate_average(employees):
    sal=0
    for i in employees:
        sal=sal+i["salary"]

    average=sal/len(employees)
    print(average)

def high_salary(employees):

    Max_sal=[]

    for i in employees:
        Max_sal.append(int(i["salary"]))
    print(max(Max_sal))

def low_salary(employees):

    Min_sal=[]

    for i in employees:
        Min_sal.append(int(i["salary"]))
    print(min(Min_sal))

def perc_inc(employees,percent):

    for i in employees:
        sal=i["salary"] + ((percent/100)*i["salary"]);
        i["new_salary"] = sal
        print(i)

def find_employee(employees, name):
    for employee in employees:
        if employee["name"].lower() == name.lower():
            print("employee found")
            for key, value in employee.items():
                 print(f"'{key}': {value}")

def above_salary(employees,salary):
    count=0
    for employee in employees:
        if(employee["salary"]>salary):
            count=count+1
    print(f"Employees earning above {salary}:  {count}")


def employee_summary(employees):
    
    salary = {}
    sal = 0

    print("Employee Summary")
    print(f"Total employees : {len(employees)}")

    for employee in employees:
        salary[employee["name"]] = employee["salary"]
        sal=sal+employee["salary"]

    for key, value in salary.items():
        if value == min(salary.values()):
                print(f"Minimum salary : {key} , {value}")

    for key, value in salary.items():
            if value == max(salary.values()):
                    print(f"Maximum salary : {key} , {value}")

    print(f"Average salary : {sal/len(employees)}")

print("1.Display all employees","\n2.Calculate average salary","\n3.Find the highest salary",
      "\n4.Find the lowest salary","\n5.Calculate salary after a percentage increment","\n6.Search for an employee",
      "\n7.Employees earning above","\n8.Employee summary")
option=int(input("Enter your option: "))

if (option == 1):
     display_employee(employees)
elif (option == 2):
     calculate_average(employees)
elif (option == 3):
     high_salary(employees)
elif (option == 4):
     low_salary(employees)
elif (option == 5):
     percent=int(input("Enter the percentage : "))
     perc_inc(employees,percent)
elif (option == 6):
     name=input("Enter the name : ")
     find_employee(employees, name)
elif (option == 7):
     salary=int(input("Enter the salary : "))
     above_salary(employees, salary)
elif (option == 8):
     employee_summary(employees)
else:
     print("Entered options are not available ")