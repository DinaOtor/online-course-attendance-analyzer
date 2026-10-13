echo "Enter course ID "
read courseID 
Number_Of_Sess=$(grep ",$courseID," Student_Record.txt |cut -d',' -f9 |sort |uniq |wc -l) 
echo "number of sessions for course $courseID is $Number_Of_Sess"

