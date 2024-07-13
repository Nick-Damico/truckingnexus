# Features

- [ ] Users can create custom quizzes
- [ ] Driver( User ) can log their HOS/Trip Logsheet and print them

## FEATURE: Users can log their HOS/trip logsheet

### Overview

The application should provide a user a way to record their daily trip logsheet or HOS log.
The application should provide a form to the user that records FMCSA's required information for a valid trip log sheet.

The application provides the driver with a form to record general information like the date, the truck & trailer numbers, their name, their home terminal, and odometer readings. The application has to provide the driver with a place to record their duty status, the duration of the duty status recorded in 15-minute increments, and a place to annotate a change in duty status with location and comment.

The application should aid the driver with logging. The aid provided should include but not be limited to FMCSA requirements like annotations on duty status changes, validation of required general information, and indications of any violations of a driver's 14-hour work clock or 10-hour drive clock.

The application will provide the driver with a place to electronically transfer logs in PDF form or print in PDF form.

### Feature List

    1. Application needs to represent a log sheet.
    2. It must track the date of the log sheets.
    3. It should use the log sheet dates to construct a 7 day time line for validation of FMSCA regulations.
    4. It provides a form to user to record their daily driver activity.
    5. It validates required information when entering a logsheet.
    6. It provides the user view of the logsheet in FMCSA format as well as a way to print to pdf.

## FEATURE: Users can create custom quizzes

### Use Cases

- Actor: "User" who creates, shares, and takes quizzes.
- Actor: "System" the application that manages quizzes and user interactions.

1. User can create a Quiz
2. User can add Questions to a Quiz
3. User can set the Quiz to Private
4. User can set the Quiz to Public
5. User can take a Quiz
6. User can rate another Users Quiz

7. System provides User a form to create Quiz
8. System allows User to set access level for Quiz
9. System provides User a form to rate Quizzes
10. System grades quiz

### Requirements

- [x] System stores Quizzes
- [x] System stores User defined Quizzes
- [ ] Users can

### Diagrams
