#!/bin/bash

# ---------------------------------------------
# Script to find students who left a session early
# ---------------------------------------------

# Prompt user to input CourseID, SessionID, and early leave threshold (Y)
read -p "Enter CourseID: " course
read -p "Enter SessionID: " session
read -p "Enter early leave threshold in minutes (Y): " Y

echo
echo "Early leavers for Course: $course, Session: $session (Threshold: $Y minutes)"
echo "--------------------------------------------------------------------------"

found=false  # Flag to track if any student left early

# Read each line from Student_Record.txt
while read -r line;
 do
    # Extract CourseID and SessionID from the line
    course_id=$(echo "$line" | cut -d',' -f6)
    session_id=$(echo "$line" | cut -d',' -f9)

    # Skip this line if CourseID or SessionID do not match user input
    if [ "$course_id" != "$course" ] || [ "$session_id" != "$session" ];
     then
        continue
    fi

    # Extract relevant fields
    fname=$(echo "$line" | cut -d',' -f3)       # First Name
    lname=$(echo "$line" | cut -d',' -f4)       # Last Name
    start=$(echo "$line" | cut -d',' -f7)       # Start Time (full timestamp)
    length=$(echo "$line" | cut -d',' -f8)      # Session Length in minutes
    leave=$(echo "$line" | cut -d',' -f11)      # Student Leave Time (HH:MM)

    # Extract time from start timestamp
    start_time=$(echo "$start" | cut -d' ' -f2)
    start_hour=$(echo "$start_time" | cut -d':' -f1)
    start_min=$(echo "$start_time" | cut -d':' -f2)

    # Convert start time to total minutes since midnight
    start_total=$((10#$start_hour * 60 + 10#$start_min))

    # Calculate official session end time in total minutes
    end_total=$((start_total + length))

    # Extract and convert leave time
    leave_hour=$(echo "$leave" | cut -d':' -f1)
    leave_min=$(echo "$leave" | cut -d':' -f2)
    leave_total=$((10#$leave_hour * 60 + 10#$leave_min))

    # Calculate how early the student left
    diff=$((end_total - leave_total))

    # If difference is greater than or equal to threshold Y, report as early leave
    if [ "$diff" -ge "$Y" ];
	 then
	 echo "$fname $lname (left $diff minutes early)"
	found=true
    fi

done < Student_Record.txt

# If no students left early
if [ "$found" = false ];
 then
    echo "No students left early."
fi
