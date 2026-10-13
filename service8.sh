#!/bin/bash

# Count how many times Zoom and Teams appear at the start of a line
ZoomCount=$(grep -c "^Zoom" Student_Record.txt)
TeamsCount=$(grep -c "^Teams" Student_Record.txt)

# Print usage counts
echo "Zoom used  : $ZoomCount times"
echo "Teams used : $TeamsCount times"

# Compare and print the most used tool
if [ $ZoomCount -gt $TeamsCount ]; then
    echo "Most frequently used tool: Zoom"
elif [ $ZoomCount -lt $TeamsCount ]; then
    echo "Most frequently used tool: Teams"
else
    echo "Zoom and Teams are used equally"
fi
