#!/bin/bash

# -------------------------------
# Script to find late students
# -------------------------------

# Prompt user for CourseID, SessionID, and late threshold (in minutes)
read -p "Enter CourseID: " course
read -p "Enter SessionID: " session
read -p "Enter late threshold in minutes (X): " X

echo
echo "Late arrivals for Course: $course, Session: $session (Threshold: $X minutes)"
echo "------------------------------------------------------------"

found_late=false  # Flag to track if any student was late

# Read file line by line
while read -r line; do
    # Extract CourseID and SessionID
    course_id=$(echo "$line" | cut -d',' -f6)
    session_id=$(echo "$line" | cut -d',' -f9)

    # Skip lines that don't match the given CourseID and SessionID
    if [ "$course_id" != "$course" ] || [ "$session_id" != "$session" ]; then
        continue
    fi

    # Extract required fields
    fname=$(echo "$line" | cut -d',' -f3)           # First Name
    lname=$(echo "$line" | cut -d',' -f4)           # Last Name
    start=$(echo "$line" | cut -d',' -f7)           # Start Time (Full timestamp)
    join=$(echo "$line" | cut -d',' -f10)           # Student Join Time

    # Extract time (HH:MM) from full timestamp
    start_time=$(echo "$start" | cut -d' ' -f2)
    start_hour=$(echo "$start_time" | cut -d':' -f1)
    start_min=$(echo "$start_time" | cut -d':' -f2)

    # Convert start time to total minutes
    start_total=$((10#$start_hour * 60 + 10#$start_min))

    # Extract join time
    join_hour=$(echo "$join" | cut -d':' -f1)
    join_min=$(echo "$join" | cut -d':' -f2)

    # Convert join time to total minutes
    join_total=$((10#$join_hour * 60 + 10#$join_min))

    # Calculate the difference
    difference=$((join_total - start_total))

    # Check if student is late
    if [ "$difference" -ge "$X" ];
	 then
        echo "$fname $lname (late by $difference minutes)"
        found_late=true
    fi

done < Student_Record.txt

# If no students were late
if [ "$found_late" = false ];
 then
    echo "No one is late."
fi
