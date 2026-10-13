# Online Course Attendance Log Analyzer

A Bash-based command-line application for analyzing sample attendance logs from online courses. It summarizes sessions and attendance across courses, instructors, and Zoom/Teams platforms.

## Features

1. Count sessions for a course
2. Average attendance per session for a course
3. Identify registered students who never attended a course
4. List late arrivals for a session (custom threshold)
5. List early departures for a session (custom threshold)
6. Average attendance duration per student and course
7. Average attendees per instructor
8. Count platform usage (Zoom vs. Teams)

## Requirements

- Bash on Linux, macOS, or WSL
- `grep`, `cut`, `sort`, `uniq`, `wc` and `bc` (`bc` is used for decimal averages)

## Run

```bash
cd online-course-attendance-analyzer
chmod +x menu.sh service*.sh
./menu.sh
```

Run from the repository directory: the scripts use relative paths to the sample data files.

## Project structure

| File | Purpose |
| --- | --- |
| `menu.sh` | Interactive menu for the eight services |
| `service1.sh` – `service8.sh` | Individual attendance-analysis operations |
| `Student_Record.txt` | Sample attendance records |
| `CS101.txt`, `CS102.txt`, `ENCS101.txt` | Sample course registration lists |
| `Test_Case.pdf` | Original test-case document |

## Notes

- Input files use comma-separated fields without a header; `Student_Record.txt` contains platform, student/course/session and attendance timestamps.
- The attendance scripts are educational examples; they assume well-formed input and largely assume sessions do not cross midnight.
- Test data is bundled for demonstration. Confirm you have permission to publish any data or report from the original coursework.

## Contributors

- Dina Otor
- Hala Khalil 

Academic team project.
