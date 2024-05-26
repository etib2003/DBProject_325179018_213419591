import random
import string

# פונקציה ליצירת שמות אקראיים
def generate_name():
    first_names = ['John', 'Jane', 'Alice', 'Bob', 'Carol', 'Dan', 'Eve', 'Frank', 'Grace', 'Henry']
    last_names = ['Smith', 'Doe', 'Johnson', 'Brown', 'Williams', 'Jones', 'Miller', 'Davis', 'Garcia', 'Wilson']
    return random.choice(first_names) + ' ' + random.choice(last_names)

# פונקציה ליצירת כתובות אקראיות
def generate_address():
    streets = ['Maple St', 'Oak St', 'Pine St', 'Elm St', 'Cedar St', 'Birch St', 'Cherry St', 'Willow St', 'Aspen St', 'Poplar St']
    return f"{random.randint(1, 999)} {random.choice(streets)}"

# פונקציה ליצירת אימיילים אקראיים
def generate_email(name):
    domains = ['ex.com', 'mail.com', 'email.com', 'web.com', 'site.com']
    name_part = name.lower().replace(' ', '.')
    return f"{name_part[:5]}@{random.choice(domains)}"

# יצירת פקודות INSERT
customers = []
for i in range(111, 550):
    name = generate_name()
    email = generate_email(name)
    address = generate_address()
    insert_statement = f"INSERT INTO CUSTOMER (CUSTOMER_ID, NAME, EMAIL, ADDRESS) VALUES ({i}, '{name}', '{email}', '{address}');"
    customers.append(insert_statement)

with open("customerPy.txt","w") as file:
# הדפסת פקודות INSERT
    for insert in customers:
        file.write(f"{insert} \n")
