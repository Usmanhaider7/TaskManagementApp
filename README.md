# Task Manager App

A simple Flutter Task Manager application with Firebase Authentication and Cloud Firestore.

## Features
- **Firebase Authentication**: Sign up and Login using Email/Password.
- **Real-time Database**: Tasks are synced in real-time using Cloud Firestore.
- **Task Management**: Create, Read, Update (Toggle Status), and Delete tasks.
- **User Specific**: Each user can only see and manage their own tasks.

## Setup Instructions

### 1. Prerequisites
- Flutter SDK installed.
- Firebase CLI installed.
- A Firebase project created in the [Firebase Console](https://console.firebase.google.com/).

### 2. Firebase Configuration
This project uses `flutterfire_cli` for configuration.
1. Run `dart pub global activate flutterfire_cli`.
2. Run `flutterfire configure` in the project root.
3. Select your Firebase project and platforms (Android/iOS).
4. This will update `lib/firebase_options.dart`.

### 3. Installation
1. Clone the repository:
   ```bash
   git clone <your-repository-url>
   ```
2. Navigate to the project folder:
   ```bash
   cd task_manager_app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```

### 4. Running the App
1. Connect an emulator or physical device.
2. Run the app:
   ```bash
   flutter run
   ```

## Folder Structure
- `lib/models/`: Data models (TaskModel).
- `lib/services/`: Firebase Auth and Firestore logic.
- `lib/views/`: UI screens for Auth, Home, and Tasks.
- `lib/main.dart`: Entry point and Auth Gate.
