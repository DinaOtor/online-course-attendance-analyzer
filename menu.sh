#!/bin/bash
while true;
do 
echo "Online Course Log Analyzer "
echo "1. Number of sessions per course "
echo "2. Average of attendance per course "
echo "3. List absent students per course "
echo "4. List of late arrivals per session "
echo "5. List of students leaving early "
echo "6. Average attendance time per student per course "
echo "7. Average of number of attendance per instructor "
echo "8. Most of frequently used tool "
echo "9. exit"
echo " Enter your choice "
read choice

case $choice in 
1) bash service1.sh  ;;
2) bash service2.sh ;; 
3) bash service3.sh    ;;
4)bash service4.sh    ;;
5) bash service5.sh ;;
6)bash service6.sh      ;;
7) bash service7.sh     ;;
8)bash service8.sh     ;;
9)echo "Exiting program";
exit 0;;
*) echo "Invalid choice  "
echo "Try again enter the number from [0-9]"
esac
done 




