# ToDoEase - A Simple Todo Application
---

### Overview:
ToDoEase is a Flutter-based mobile application designed to help users manage their daily tasks efficiently. The application provides a simple and intuitive interface for users to add, update, and mark tasks as completed. It utilizes JWT (JSON Web Token) for user authentication and stores tokens securely using SharedPreferences to maintain user sessions. The app communicates with a backend server to handle user authentication and manage task data.

![ToDoEase](https://github.com/dineshxo/ToDoEase-2.0/assets/95670930/125d7f58-5723-46a7-9c3d-195d8908674b)

### Key Features:

#### User Authentication:
- **Login:** Users can log in to their accounts securely.
- **Registration:** New users can create accounts.
- **Token Management:** JWT tokens are used to authenticate users, and tokens are stored locally using SharedPreferences.

#### Task Management:
- **Home Screen:** Displays a list of tasks fetched from the backend server.
- **Add Task:** Users can add new tasks to their list.
- **Mark as Completed:** Tasks can be marked as completed using a checkbox. The checkbox is customized to have a white fill and a green tick.

#### Custom UI Elements:
- **Google Fonts:** The app uses the Raleway font for a modern and clean look.
- **Custom Checkbox:** The checkbox for marking tasks as completed has a white fill color and a green tick.

### Technologies Used:

#### Frontend:
- **Flutter:** For building the cross-platform mobile application.
- **Google Fonts:** For custom fonts.
- **JWT Decoder:** For decoding and validating JWT tokens.
- **SharedPreferences:** For storing user tokens locally.
- **Material Design 3:** For modern UI components.

#### Backend:
- **Node.js and Express:** For creating the RESTful API.
- **MongoDB:** For database management to store user information and tasks.
- **JWT:** For handling user authentication.

### Project Structure:

#### Frontend (Flutter):
- `main.dart`: Entry point of the application. It initializes the app and checks for stored JWT tokens to determine if the user should be navigated to the home screen or login screen.
- **Screens:**
  - **Home:** Displays the list of tasks and allows users to mark tasks as completed.
  - **Login:** Provides a form for users to log in.
  - **Registration:** Allows new users to create an account.

#### Backend (Node.js/Express):
- `server.js`: Entry point for the backend server.
- `routes`: Contains route definitions for user authentication and task management.
- `models`: Contains Mongoose models for users and tasks.
- `controllers`: Contains logic for handling API requests and interacting with the database.
