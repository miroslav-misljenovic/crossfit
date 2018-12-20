CFLAGS	= gcc -g -Wall `mysql_config --cflags --libs`

.PHONY: all

all: create insert upiti 

create:
	mysql -u root -p -D mysql <script.sql

insert:
	mysql -u root -p -D mysql <insert.sql
	
upiti:
	$(CFLAGS) upiti.c -o upiti