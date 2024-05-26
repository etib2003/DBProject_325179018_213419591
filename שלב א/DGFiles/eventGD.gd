
[General]
Version=1

[Preferences]
Username=
Password=2719
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=ETI
Name=EVENT
Count=400

[Record]
Name=EVENT_DATE
Type=DATE
Size=
Data=Random(01/01/2020, 29/12/2028)
Master=

[Record]
Name=LOCATION
Type=VARCHAR2
Size=15
Data=List('Royal Garden Hall', 'Diamond Palace', 'Crystal Ballroom', 'Golden Plaza',
=    'Emerald Manor', 'Silver Springs Hall', 'Pearl Pavilion', 'Sapphire Hall',
=    'Amethyst Ballroom', 'Opal Palace', 'Topaz Terrace', 'Ruby Gardens',
=    'Platinum Plaza', 'Jade Hall', 'Onyx Mansion', 'Sunset Ballroom',
=    'Starlight Pavilion', 'Moonbeam Hall', 'Celestial Terrace', 'Aurora Ballroom',
=    'Gilded Palace', 'Enchanted Gardens', 'Majestic Manor', 'Elegant Terrace',
=    'Grand Oasis Hall', 'Luxury Pavilion', 'Regal Ballroom', 'Elite Mansion',
=    'Harmony Hall', 'Victory Pavilion', 'Cherished Gardens', 'Grandeur Hall',
=    'Eclipse Ballroom', 'Heavenly Terrace', 'Exquisite Pavilion', 'Imperial Mansion',
=    'Tranquil Gardens', 'Noble Hall', 'Dazzle Pavilion', 'Glamorous Ballroom',
=    'Mystic Terrace', 'Dreamy Manor', 'Radiant Hall', 'Serene Pavilion',
=    'Whispering Gardens', 'Ethereal Ballroom', 'Blissful Palace', 'Breathtaking Terrace'
=)
Master=

[Record]
Name=TOTAL_PRICE_
Type=NUMBER
Size=5
Data=random(8000,15000)
Master=

[Record]
Name=EVENT_ID
Type=NUMBER
Size=5
Data=sequence(1)
Master=

[Record]
Name=PRODUCER_ID
Type=NUMBER
Size=5
Data=List(select producer_id from producer)
Master=

[Record]
Name=SINGER_ID
Type=NUMBER
Size=5
Data=List(select singer_id from singer)
Master=

[Record]
Name=CUSTOMER_ID
Type=NUMBER
Size=5
Data=List(select customer_id from customer)
Master=

[Record]
Name=PAYMENT_ID
Type=NUMBER
Size=5
Data=List(select payment_id from payment_type)
Master=

