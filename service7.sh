#!/bin/bash

echo "Average number of attendances per instructor:"

# Get unique instructor names
instructors=$(cut -d',' -f5 Student_Record.txt | sort -u)

# Loop over each instructor
for instr in $instructors; do
    total_students=0
    total_sessions=0

    # Get unique sessions (CourseID, SessionID) for the instructor
    sessions=$(grep ",$instr," Student_Record.txt | cut -d',' -f6,9 | sort -u)

    # Loop through each session
    while read -r line; do
        course_id=$(echo "$line" | cut -d',' -f1)
        session_id=$(echo "$line" | cut -d',' -f2)

        # Count students in this session
        count=$(grep ",$instr," Student_Record.txt | grep ",$course_id," | grep ",$session_id," | wc -l)

        total_students=$((total_students + count))
        total_sessions=$((total_sessions + 1))
    done <<< "$sessions"

    # Calculate and print average
    if [ $total_sessions -gt 0 ]; then
        avg=$(echo "scale=2; $total_students / $total_sessions" | bc)
        echo "Instructor $instr: $avg students per session on average"
    fi
done
