
import os
import sys

def insertval(tablename,valtoinsert):
	fout = open("updatetable.sql",'a');
	if(tablename == "facinfo"):
		query ="INSERT INTO "+tablename+"(fac_name,email,phone,responsibility,website,designation) VALUES(\""+valtoinsert[0]+"\",\""+valtoinsert[3]+"\",\""+valtoinsert[4]+"\",\""+valtoinsert[2]+"\",\""+valtoinsert[5]+"\",\""+valtoinsert[1]+"\");\n"
		fout.write(query)
		return
	elif(tablename == "publications"):
		query ="INSERT INTO "+tablename+"(fac_name,pub_year,pub_title) VALUES(\""+valtoinsert[0]+"\",\""+valtoinsert[1]+"\",\""+valtoinsert[2]+"\");\n"
		fout.write(query)
		return
	elif(tablename == "projects"):
		query ="INSERT INTO "+tablename+"(fac_name,project_title) VALUES(\""+valtoinsert[0]+"\",\""+valtoinsert[1]+"\");\n"
		fout.write(query)
		return
	elif(tablename == "students"):
		query ="INSERT INTO "+tablename+"(fac_name,student_name,student_type,std_research_area) VALUES(\""+valtoinsert[0]+"\",\""+valtoinsert[1]+"\",\""+valtoinsert[2]+"\",\""+valtoinsert[3]+"\");\n"
		fout.write(query)
		return
	fout.close()

def runquery(fname):
	file = open(fname,'r');
	if(file == None): print("error opening file")
	line = file.readline()
	valtoinsert=[]
	for i in range(0,6):
		valtoinsert.append("")
	fac_name =""
	while(line != ""):
		if("NAME$" in line):
			data = line.split("$")
			valtoinsert[0] = data[1].rstrip('\n\r')
			fac_name = valtoinsert[0]
			while("AWARDS\n" not in line or line != ""):
				line = file.readline()
				if("PHONE$" in line):
					data = line.split("$")
					valtoinsert[4]=data[1].rstrip('\n\r')
				elif("DESG$" in line):
					data = line.split("$")
					valtoinsert[1]=data[1].rstrip('\n\r')
				elif("EMAIL$" in line):
					data = line.split("$")
					valtoinsert[3] =data[1].rstrip('\n\r')
				elif("WEB$" in line):
					data = line.split("$")
					valtoinsert[5] =data[1].rstrip('\n\r')
				elif("RESP$" in line):
					data = line.split("$")
					valtoinsert[2]= data[1].rstrip('\n\r')
				if("AWARDS\n" in line):
					break
				if("PUBLICATIONS\n" in line):
					break
				if(line == "" or line == "\n"):
					break;
			insertval("facinfo",valtoinsert)
		
		if("PUBLICATIONS" in line):
			line = file.readline()
			while("PROJECTS\n" not in line):
				year = line.rstrip('\n\r')
				line =file.readline()
				pub = line.rstrip('\n\r')
				valtoinsert = [fac_name, year[:4],pub]
				insertval("publications",valtoinsert)
				line =file.readline()
				line =file.readline()
		
		if("PROJECTS" in line):
			line = file.readline()
			while("STUDENTS\n" not in line):
				pro = line.rstrip('\n\r')
				line = file.readline()
				valtoinsert=[fac_name,pro]
				insertval("projects",valtoinsert)
				line = file.readline()

		if("STUDENTS" in line):
			line = file.readline()
			if("PhD STUDENTS\n" in line):	
				line = file.readline()
				while("MS STUDENTS" not in line ):
					data=line.split("Area of Research:")
					line = file.readline()
					valtoinsert=[fac_name,data[0].rstrip('\n\r'),"Ph.D. Student",data[1].rstrip('\n\r')]
					insertval("students",valtoinsert)
					line = file.readline()
					if(line == "" or line =='\n'):
						break;
			if("MS STUDENTS\n" in line):
				line = file.readline()
				while(line != ""):
					data = line.split("Area of Research:")
					line = file.readline()
					valtoinsert=[fac_name,data[0].rstrip('\n\r'),"MS Student",data[1].rstrip('\n\r')]
					insertval("students",valtoinsert)
					line = file.readline()
					if(line == "" or line =='\n'):
						break;
		line =file.readline()

def main(): 
	os.remove('updatetable.sql')
	profs = os.listdir('./databaseinp')
	#runquery("./databaseinp/anupam.csv")
	for p in profs:
		print(p)
		runquery("./databaseinp/"+p)

if __name__ == '__main__':
		main()	

