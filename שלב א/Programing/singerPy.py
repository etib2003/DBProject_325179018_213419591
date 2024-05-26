import random

# פונקציה ליצירת שמות אקראיים
def generate_name():
    first_names = ['John', 'Jane', 'Alice', 'Bob', 'Carol', 'Dan', 'Eve', 'Frank', 'Grace', 'Henry']
    last_names = ['Smith', 'Doe', 'Johnson', 'Brown', 'Williams', 'Jones', 'Miller', 'Davis', 'Garcia', 'Wilson']
    return random.choice(first_names) + ' ' + random.choice(last_names)

# פונקציה ליצירת מחירים אקראיים
def generate_price():
    return random.randint(1000, 10000)  # מחירים בין 1000 ל-10000

# יצירת פקודות INSERT
singers = []
for i in range(11, 451):
    name = generate_name()
    price = generate_price()
    insert_statement = f"INSERT INTO Singer (Id, Sname, Price) VALUES ({i}, '{name}', {price});"
    singers.append(insert_statement)

# כתיבת פקודות INSERT לקובץ
with open("singersPy.txt", "w") as file:
    for insert in singers:
        file.write(f"{insert}\n")

print("Insert statements written to singersPy.txt")
