#!/bin/bash

read -p "Enter CourseID: " course

echo "Average attendance time per student for course $course:"

# Get unique students in this course (ID, First Name, Last Name)
students=$(grep ",$course," Student_Record.txt | cut -d',' -f2,3,4 | sort -u)

# Loop through each student
for student in $students; do
    sid=$(echo "$student" | cut -d',' -f1)
    fname=$(echo "$student" | cut -d',' -f2)
    lname=$(echo "$student" | cut -d',' -f3)

    # Create a temp file with this student's attendance records
    tmpfile=$(mktemp)
    grep ",$sid,.*,$course," Student_Record.txt > "$tmpfile"

    total=0   # Total time attended
    count=0   # Session count

    # Loop through each session line
    while read -r line; do
        # Extract join time in minutes
        join_time=$(echo "$line" | cut -d',' -f10)
        jh=$(echo "$join_time" | cut -d':' -f1)
        jm=$(echo "$join_time" | cut -d':' -f2)
        join_total=$((10#$jh * 60 + 10#$jm))

        # Extract leave time in minutes
        leave_time=$(echo "$line" | cut -d',' -f11)
        lh=$(echo "$leave_time" | cut -d':' -f1)
        lm=$(echo "$leave_time" | cut -d':' -f2)
        leave_total=$((10#$lh * 60 + 10#$lm))

        # Calculate session duration
        duration=$((leave_total - join_total))

        total=$((total + duration))
        count=$((count + 1))
    done < "$tmpfile"

    # Calculate average time
    if [ $count -gt 0 ]; then
        avg=$((total / count))
        echo "$fname $lname (ID=$sid): $avg minutes on average"
    fi

    # Delete temp file
    rm "$tmpfile"
done
