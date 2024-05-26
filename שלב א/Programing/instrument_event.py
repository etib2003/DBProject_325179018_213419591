import random

# קביעת טווחי ה-IDs
instrument_id_range = range(1, 51)  # Instrument IDs בין 1 ל-50
event_id_range = range(1, 401)      # Event IDs בין 1 ל-400

# יצירת סט של צמדים ייחודיים
unique_pairs = set()

while len(unique_pairs) < 400:
    instrument_id = random.choice(instrument_id_range)
    event_id = random.choice(event_id_range)
    unique_pairs.add((instrument_id, event_id))

# יצירת פקודות INSERT
inserts = []
for instrument_id, event_id in unique_pairs:
    insert_statement = f"INSERT INTO Instrument_Event (Instrument_Id, Event_Id) VALUES ({instrument_id}, {event_id});"
    inserts.append(insert_statement)

# כתיבת פקודות INSERT לקובץ
with open("instrument_eventPy.txt", "w") as file:
    for insert in inserts:
        file.write(f"{insert}\n")

