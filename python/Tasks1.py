# def is_even(number):
#     if (number%2 == 0):
#         print("its even number")
#     else:
#         print("not an even number")
# 
# number = int(input("Enter the number: "))
# is_even(number)
# 
# def large_value(number1,number2):
#     if(number1>number2):
#         print(number1, "is the largest")
#     elif(number2>number1):
#         print(number2, "is the largest")
#     else:
#         print(number1,"and", number2, "are same")
# 
# number1 = int(input("Enter the number 1: "))
# number2 = int(input("Enter the number 2: "))
# large_value(number1,number2)
# 
# def default_parameter(quotes,country="INDIA"):
#     print(quotes,country)
# 
# quotes="my country is"
# default_parameter(quotes)
# default_parameter(quotes,"ind")
# 
# multiply= lambda X: X * 10
# number = int(input("Enter the number: "))
# print(multiply(number))
# 
# employee_name=["arun","Raj","sri","mani","anu"]
# employee_name.append("priya")
# employee_name.remove("Raj")
# print(employee_name)
# 
# num_list = [1,2,3,4,5]
# num_set=set(num_list)
# print(num_list)
# print(num_set)
# 
# city=("chennai","mumbai","bangalore")
# print(city[1])
# 
# students = [
#     {"name": "sri", "age": 33, "mark": 85},
#     {"name": "ram", "age": 30, "mark": 90},
#     {"name": "kumar", "age": 28, "mark": 88}
# ]
# 
# students[0]["mark"]=95
# print(students)
# 
# students = [
#     {"name": "sri", "age": 33, "mark": 85},
#     {"name": "ram", "age": 30, "mark": 90},
#     {"name": "kumar", "age": 28, "mark": 88}
# ]
# for lp in students:
#     for item in lp.items():
#         print(item)
# 
# def sumoflist(datalis_t):
#     return sum(datalis_t)
# 
# datalis_t=[1,2,3,4,5]
# result = sumoflist(datalis_t)
# print(result)

# mini challange

# student_details = {
#     "raj" : [60,80,90,55],
#     "sri" : [88,67,92,77],
#     "arun" : [77,56,91,78],
#     "priya" : [77,77,77,77]
#     }

# def avg_calc(student_details):
#     for lp in student_details.items():
#             print(lp[0],sum(lp[1])/len(lp[1]))
# avg_calc(student_details)
