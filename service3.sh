#!/bin/bash

# Ask for CourseID
echo "Enter CourseID"
read courseID

# Set registration file name
file="${courseID}.txt"

# Check if registration file exists
if [ ! -f "$file" ]; then
    echo "Registration file $file not found!"
    exit 1
fi

echo "Absent students for course $courseID"

# Get list of present student IDs from attendance records
present_ids=$(grep ",$courseID," Student_Record.txt | cut -d',' -f2 | sort -u)

found=0  # Flag to check if any absent student is found

# Loop through registered students
while read -r line; do
    sid=$(echo "$line" | cut -d',' -f1)       # Student ID
    FirstName=$(echo "$line" | cut -d',' -f2) # First Name
    LastName=$(echo "$line" | cut -d',' -f3)  # Last Name

    # Check if student ID is NOT in the list of present IDs
    if ! echo "$present_ids" | grep -q "$sid"; then
        echo "$FirstName $LastName"
        found=1
    fi
done < "$file"

# If all students attended
if [ $found -eq 0 ]; then
    echo "All students have attended course $courseID"
fi
