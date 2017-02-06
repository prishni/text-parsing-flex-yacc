
import os
import sys

def insertval(tablename,valtoinsert):
	fout = open("updatetable.sql",'a');
	if(tablename == "faculty_info"):
		query ="INSERT INTO "+tablename+"(faculty_name,email,phone,responsibility,website,designation,research_area) VALUES(\""+valtoinsert[0]+"\",\""+valtoinsert[3]+"\",\""+valtoinsert[4]+"\",\""+valtoinsert[2]+"\",\""+valtoinsert[5]+"\",\""+valtoinsert[1]+"\",\""+valtoinsert[6]+"\");\n"
		fout.write(query)
		return
	elif(tablename == "publications"):
		query ="INSERT INTO "+tablename+"(faculty_name,pub_year,pub_title) VALUES(\""+valtoinsert[0]+"\",\""+valtoinsert[1]+"\",\""+valtoinsert[2]+"\");\n"
		fout.write(query)
		return
	elif(tablename == "projects"):
		query ="INSERT INTO "+tablename+"(faculty_name,project_title) VALUES(\""+valtoinsert[0]+"\",\""+valtoinsert[1]+"\");\n"
		fout.write(query)
		return
	elif(tablename == "students"):
		query ="INSERT INTO "+tablename+"(faculty_name,student_name,student_type,std_research_area) VALUES(\""+valtoinsert[0]+"\",\""+valtoinsert[1]+"\",\""+valtoinsert[2]+"\",\""+valtoinsert[3]+"\");\n"
		fout.write(query)
		return
	elif(tablename == "awards"):
		query ="INSERT INTO "+tablename+"(faculty_name,award) VALUES(\""+valtoinsert[0]+"\",\""+valtoinsert[1]+"\");\n"
		fout.write(query)
		return
	fout.close()

def runquery(fname):
	file = open(fname,'r');
	if(file == None): print("error opening file")
	line = file.readline()
	valtoinsert1=[]
	valtoinsert =[]
	for i in range(0,7):
		valtoinsert1.append("")
		valtoinsert.append("")
	fac_name =""
	while(line != ""):
		if("NAME$" in line):
			data = line.split("$")
			valtoinsert1[0] = data[1].rstrip('\n\r')
			fac_name = valtoinsert1[0]
			while("AWARDS\n" not in line or line != ""):
				line = file.readline()
				if("PHONE$" in line):
					data = line.split("$")
					valtoinsert1[4]=data[1].rstrip('\n\r')
				elif("DESG$" in line):
					data = line.split("$")
					valtoinsert1[1]=data[1].rstrip('\n\r')
				elif("EMAIL$" in line):
					data = line.split("$")
					valtoinsert1[3] =data[1].rstrip('\n\r')
				elif("WEB$" in line):
					data = line.split("$")
					valtoinsert1[5] =data[1].rstrip('\n\r')
				elif("RESP$" in line):
					data = line.split("$")
					valtoinsert1[2]= data[1].rstrip('\n\r')
				if("AWARDS\n" in line):
					break
				if("RESEARCH\n" in line):
					break
				if(line == "" or line == "\n"):
					break;
		if("AWARDS" in line):
			line = file.readline()
			turn =1
			while("RESEARCH\n" not in line or line != ""):
				if(line == "\n"):
					line = file.readline()
					continue
				line =line.replace("<li>","")
				line =line.replace("</li>","")
				valtoinsert= [fac_name,line.rstrip('\n\r')]
				if(turn == 1 ):
					insertval("awards",valtoinsert)
				turn = not(turn)
				line = file.readline()
				if("RESEARCH" in line):
					break
		if("RESEARCH" in line):
			line = file.readline()
			while(line == '\n' or line == '\t'):
				line= file.readline()
			if("\"" in line):
				line= line.replace("\"","")
				line = line.replace("\'","")
			valtoinsert1[6] = line.rstrip('\n\r')
			insertval("faculty_info",valtoinsert1)
			line =file.readline()
			if(line == '\n'):
				while(line =='\n'):
					line= file.readline()
					if("PUBLICATIONS" in line):
						break

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
				while("MS STUDENTS" not in line or line != "" ):
					if("Area of Research:" in line):
						data=line.split("Area of Research:")
						line = file.readline()
						valtoinsert=[fac_name,data[0].rstrip('\n\r'),"Ph.D. Student",data[1].rstrip('\n\r')]
						insertval("students",valtoinsert)
						line = file.readline()
						if(line == "" or line =='\n'):
							break;
					else:
						break;
			if("MS STUDENTS\n" in line):
				line = file.readline()
				while(line != ""):
					if("Area of Research:" in line):
						data = line.split("Area of Research:")
						line = file.readline()
						valtoinsert=[fac_name,data[0].rstrip('\n\r'),"MS Student",data[1].rstrip('\n\r')]
						insertval("students",valtoinsert)
						line = file.readline()
						if(line == "" or line =='\n'):
							break
					else:
						break
		line =file.readline()

str = "delete from faculty_info where 1; delete from projects where 1; delete from publications where 1; delete from students where 1; delete from awards where 1;\n"

def main(): 
	#os.remove('updatetable.sql')
	f = open("updatetable.sql","w")
	f.write(str)
	f.close()
	profs = os.listdir('./databaseinp')
	#runquery("./databaseinp/sudeshna.csv")
	for p in profs:
		print(p)
		runquery("./databaseinp/"+p)

if __name__ == '__main__':
		main()	

