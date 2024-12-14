# Flutter Food Ordering Application

This is a Flutter application designed for a food ordering system that runs on multiple platforms. Below are the instructions to set up and run the project, focusing on Android development.

---

## 📋 Prerequisites

Before you get started, ensure you have the following installed:

1. **Flutter SDK**  
   Install the Flutter SDK from the official [Flutter Installation Guide](https://docs.flutter.dev/get-started/install).

2. **Android Studio**  
   Install Android Studio for Android development.  
   [Download Android Studio](https://developer.android.com/studio)

3. **Java Development Kit (JDK)**  
   Ensure the JDK is installed. Android Studio typically includes it, but you can also download it separately from [Oracle JDK](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html).

4. **Device or Emulator**  
   - Connect a physical Android device via USB with *Developer Mode* enabled.  
   - Or, set up an Android emulator in Android Studio.

5. **Environment Variables**  
   - Add `flutter` to your system’s PATH to run Flutter commands from any directory.
   - Ensure the Android SDK is properly configured in Android Studio.

---

## 🚀 Steps to Run the Project

Follow the steps below to set up and run the application on Android:

## 1️⃣ Clone the Repository
Clone the repository to your local machine:

**git clone https://github.com/Afraranver/food_ordering_application.git**

**cd food_ordering_application**

## 2️⃣ Install Dependencies
Download and set up all necessary Flutter packages by running:

**flutter pub get**

This ensures that all required dependencies for the project are installed.

## 3️⃣ Set Up a Device or Emulator
📱 Using a Physical Device
Connect your Android device to your computer via USB.
Enable USB Debugging in the device's Developer Options.
Verify the device is detected by running:


**flutter devices**

💻 Using an Emulator
Open Android Studio.
Navigate to Tools > Device Manager and create a new Android Virtual Device (AVD).
Start the emulator from the Device Manager.

## 4️⃣ Verify the Flutter Environment
Run the following command to ensure your Flutter setup is correct:

**flutter doctor**

This will display any missing dependencies or configuration issues. Make sure to resolve any errors before proceeding.

## 5️⃣ Launch the Application
Start the application by running:

**flutter run**

This will build and launch the app on the connected Android device or emulator. You should now see the application running! 🎉

## 💡 Additional Notes
Debugging Mode: Use the following command during development for a better debugging experience:

**flutter run --debug**
Release APK: To build a release APK, run:

**flutter build apk --release**
The APK will be located in the build/app/outputs/flutter-apk/ directory.

