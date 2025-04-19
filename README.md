# 📱 Tracking System via Surveillance Footage

---

## 📝 Project Description

This mobile application allows for **automatic face detection** from surveillance camera recordings. Detected faces are **saved in a MySQL database** along with:

- 📍 Location (where the person was seen)
- 🕒 Timestamp (when they were seen)

Through **facial recognition**, a **super-user** can search for an individual and retrieve **all visited locations** by that person.

User **authentication is secured using Firebase**, and only verified super-users can access sensitive tracking features.

---

## 📂 Project Structure
```plaintext
Face Detection & Tracking System via Surveillance Footage/
├── android/ # Android-specific files (Gradle, Manifest, etc.)
├── images/ # Saved face images (snapshots)
├── lib/ # Flutter app source code (UI, Firebase, etc.)
├── python/ # Python scripts for video processing and facial recognition
├── test/ # Flutter unit and widget tests
├── pubspec.yaml # Flutter dependencies and configuration
├── README.md # This file


```
---

## ⚙️ Features

- 🎥 Process recorded videos from surveillance cameras
- 🤖 Detect faces using **Dlib** and **OpenCV**
- 🧠 (Planned) Facial recognition to identify people
- 🕒 Assign timestamps based on video data
- 🌍 Attach and store locations
- 🗃️ Save to MySQL with face image, location, and time
- 🔐 Secure login & sign-up with **Firebase Authentication**
- 🔎 Super-user can search a person by face and see their location history

---

## 🛠️ Technologies Used

| Technology         | Purpose                                   |
|--------------------|--------------------------------------------|
| Flutter (Dart)      | Mobile app development                    |
| Firebase Auth       | User authentication (login & sign-up)     |
| Python              | Backend processing and face detection     |
| Dlib + OpenCV       | Face detection from video frames          |
| MySQL               | Relational database for storing results   |

---

## 🚀 Installation & Setup

1. Install dependencies:
```bash
flutter pub get
```
2.
```bash
flutter run
```
---


## 📬 Contact
Author: Aymen Besbes & Aws Gandouz Email: Aymen.besbes@outlook.com | Aymen.besbes@ensi-uma.tn

LinkedIn: https://www.linkedin.com/in/aymen-besbes-158837245/

---

## 📅 Project Timeline
Original creation date: February-April 2023
Upload to GitHub: April 2025

