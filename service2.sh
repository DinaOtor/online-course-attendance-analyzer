#!/bin/bash

# Ask for Course ID
echo "Enter Course ID: "
read courseID

# Total student records for the course
Total_Student=$(grep ",$courseID," Student_Record.txt | cut -d',' -f2 | wc -l)

# Count unique session IDs for the course
Sess_Of_course=$(grep ",$courseID," Student_Record.txt | cut -d',' -f9 | sort | uniq | wc -l)

# Check if sessions exist
if [ "$Sess_Of_course" -eq 0 ]; then
    echo "No session found for course $courseID"
else
    # Calculate average attendance
    averageStudent=$(echo "scale=2; $Total_Student / $Sess_Of_course" | bc)
    echo "Average attendance per session for course $courseID: $averageStudent"
fi
