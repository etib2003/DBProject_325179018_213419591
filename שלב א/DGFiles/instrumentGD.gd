
[General]
Version=1

[Preferences]
Username=
Password=2653
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=ETI
Name=INSTRUMENT_EVENT
Count=400

[Record]
Name=INSTRUMENT_ID
Type=NUMBER
Size=5
Data=List(select instrument_id from instrument)
Master=

[Record]
Name=EVENT_ID
Type=NUMBER
Size=5
Data=List(select event_id from event)
Master=

