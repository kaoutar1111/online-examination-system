# Online Examination System

A web application for running exams in an educational setting. It has three user roles (Admin, Teacher and Student) and covers user management, a question bank, exam creation and scheduling, automatic and manual grading, and performance statistics.

## Features

**All users**
- Registration and AJAX login (no page reload), with hashed passwords
- Password recovery and reset
- Role-based access: each role sees only its own pages

**Admin**
- View all registered users
- Edit and delete user accounts

**Teacher**
- Create, edit and delete questions, organised by topic or type
- Four question types: single choice, multiple choice, fill in the blank, short answer
- Import and export questions and results with Excel files
- Build an exam manually or generate one randomly from the question bank
- Schedule and publish exams
- Automatic grading of objective questions, and manual grading of short answers
- Statistics on student performance

**Student**
- See the available exams and start one
- Countdown timer with automatic submission when time runs out
- Answers are saved automatically during the exam (AJAX)
- View the result after grading

## Technology

| Layer | Technology |
| --- | --- |
| Frontend | HTML5, CSS3 (responsive, glass-morphism style), vanilla JavaScript, Fetch API with JSON |
| Backend | PHP with sessions |
| Database | MySQL (database `onlinesystem`) through MySQLi prepared statements |
| Environment | XAMPP (Apache, PHP, MySQL) |
| Other | Excel library for import and export|

## Architecture

A client-server design that follows the MVC idea:

- **View:** the HTML, CSS and JavaScript pages. They send requests with the Fetch API and update the page from the JSON replies.
- **Controller:** the PHP scripts handle login, registration, form input, validation, exam submission and sessions, and return JSON.
- **Model:** the MySQL database stores users, questions, exams, results and answers.

## Database

| Table | Content |
| --- | --- |
| `users` | Login details and role |
| `exams` | Exam information |
| `questions` | Questions for each exam |
| `student_exam` | Which student took which exam, and the score |
| `answers` | Each answer a student gave |

The structure is in `DateBase/Table.sql`.

## Installation

Requirements: XAMPP (PHP and MySQL) and a modern browser (Chrome, Edge or Firefox).

1. Copy the project folder into `C:\xampp\htdocs\`.
2. Start **Apache** and **MySQL** in the XAMPP control panel.
3. Open phpMyAdmin (`http://localhost/phpmyadmin`), create a database named `onlinesystem`, and import `DateBase/Table.sql`.
4. The PHP files that connect to the database contain the placeholder `YOUR_DB_PASSWORD`. Replace it with your own MySQL password (XAMPP's default for `root` is an empty password, so use `""`).
5. Open `http://localhost/<project-folder>/firstPage.html`.

## User guide

1. **Register:** on the login page, click "Register a new user", fill in name, email, password and role, and submit.
2. **Log in:** enter your email and password. You are sent to the page for your role.
3. **Forgot password:** use the "Forgot your password?" link and enter your email.
4. **Admin:** open the user management page to view, edit or delete accounts.
5. **Teacher:** add questions, then build or randomly generate an exam, schedule and publish it, and grade the submissions. Short answers are graded by hand.
6. **Student:** open an available exam, answer within the time limit, submit, and view the result after grading.

## Security

- Passwords are hashed with `password_hash()` and checked with `password_verify()`. No plain-text passwords are stored.
- All database queries use MySQLi prepared statements, which protects against SQL injection.
- PHP sessions keep the login state (user id, email and role), and protected pages need a login.
- Role-based access control separates Admin, Teacher and Student pages.
- Inputs are validated on the client (JavaScript) and the server (PHP).

## Testing

All core features were tested by hand:

| Area | What was checked |
| --- | --- |
| Login and registration | Valid and invalid logins, duplicate email, required fields |
| Password recovery | Link navigation and field checks |
| Role-based access | Correct page for each role |
| Question management | Add, edit and delete, and choosing the question type |
| Exam interface | Timer, question navigation, auto-save |
| Exam submission | Submit on time and early, unanswered questions |
| Grading | Automatic scoring for multiple choice, manual grading for short answers |
| Interface | Layout on desktop, tablet and phone |
| Security | Password hashing confirmed in the database, SQL injection attempts blocked, session tampering checked, script injection checked |

Tools: browser developer tools (Chrome and Edge), Postman for the PHP endpoints, and phpMyAdmin for the database. Performance work included fewer full-page reloads (Fetch API), an index on the user email for fast login lookups, and removing repeated PHP code.

## Limitations and future work

- No email verification for new users.
- No automatic logout after inactivity.
- No exam resume after a page refresh (planned: keep answers in session storage).
- Anti-cheating measures are planned but not built: tab-switch detection, blocking right-click and copy, and logging suspicious behaviour.
- Statistics are basic. Charts (for example with Chart.js) are a possible improvement.
- The registration form lets a user choose the Admin role, which is acceptable for a prototype but must be restricted in real use.
- The database password is set directly in each PHP file. A single configuration file would be better.

## Project structure

| File or folder | Purpose |
| --- | --- |
| `firstPage.html`, `login.php` | Login page and login handling |
| `register.html`, `register.php`, `registerAttempts.php` | Registration |
| `recover.html`, `recoverPassword.php`, `reset.html`, `resetPasswod.php` | Password recovery and reset |
| `management.html`, `listUser.php`, `editUser.php`, `Exclude.php` | Admin: user management |
| `registerQuestion.html`, `registerQuestion.php`, `saveQuest.php`, `editQuest.php`, `read.php`, `delete.php` | Teacher: question bank |
| `Import.php`, `ImportQuestions.php`, `importExp.html`, `Export.php`, `exportResults.php` | Excel import and export |
| `makeExam.html`, `makeTest.html`, `MakeTest.php`, `CreateTest.html`, `generateTest.php`, `ListTest.php`, `listExams.php`, `ExamsAgenda.php` | Exam creation, random generation and scheduling |
| `AvailableExams.html`, `DoExams.html`, `saveAnswer.php` | Student: available exams, taking an exam, auto-save |
| `automaticGrading.php`, `SubjectiveCorrection.html`, `listSubjetiveNotCorrected.php`, `saveManualCorrection.php` | Automatic and manual grading |
| `statistics.html`, `statisticsMarks.php` | Statistics |
| `Css/` | Stylesheets |
| `DateBase/Table.sql` | Database structure |
