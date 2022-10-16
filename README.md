# Gatherly Frontend Mobile

![Gatherly](readme_images/logo.png)

## About Gatherly

Gatherly is a mobile based application, which helps socially isolated young people to join events and socialise. Gatherly shows events around the user based on their interests and the user can swipe left or right on the events to either skip or join the events. They can also see the event details and the number of participants before joining an event to make sure they are comfortable when attending the events. Gatherly also provides search feature for people that wants to schedule events beforehand.

## About the Repository

This repository contains the code base for the main mobile application

## Technology Stacks

- Flutter 3.3.4

## Folder Structure

```
└── lib
    ├── common
    │   ├── assets: assets such as image, font, etc.
    │   ├── bloc: bloc state management base
    │   ├── components: widgets used across the app
    │   ├── config: general configuration and constants
    │   ├── data: base model, repository, and data provider
    │   ├── exception: custom exceptions
    │   ├── network: handles network tasks
    │   └── utils: static utility classes
    ├── service_name
    │   ├── bloc: bloc state management for the service
    │   ├── components: widgets used by the service
    │   └── data: model, repository, and data provider for the service
    └── pages
        └── service_name: pages for the service
```

## Getting Started

### Prerequisites

Before installing the project, make sure you have Flutter installed by following this [guide](https://docs.flutter.dev/get-started/install) provided by the flutter team.

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/deco-freons/fe-mobile-flutter.git
   ```
2. Install package dependencies in `pubspec.yaml`
   ```bash
   flutter pub get
   ```
3. Create `.env` file and write
   ```sh
   googleApiKey='YOUR_GOOGLE_API_KEY'
   releaseEnv='dev' or 'prod' or 'demo'
   ```
   - example:
     ```sh
     googleApiKey='CIzaSGAJ0****EXAMPLE****xhC8q5_ftdogbvw'
     releaseEnv='prod'
     ```

### Running the Project

- Android Device
  - Enable [Developer options](https://developer.android.com/studio/debug/dev-options)
  - Enable `USB Debugging` in Developer options
  - Plug your device to a computer with a USB cable and allow `USB debugging` if asked
  - Run the project
    ```sh
    flutter pub run lib/main.dart
    ```
- Android Emulator
  - Download Android Studio from this [link](https://developer.android.com/studio)
  - Open your Android Studio
  - Go to your SDK manager by clicking **More Actions > SDK Manager**
    ![Sdk_manager](readme_images/sdk_manager.png)
  - Navigate to SDK Tools tab and make sure that these tools are installed:
    - Android SDK Command Line Tools
    - Android Emulator
    - Android SDK Platform Tools
      ![Sdk_tools](readme_images/sdk_tools.png)
  - Go to your virtual device manager by clicking **More Actions > Virtual Device Manager**
  - Click **Create device**
  - Choose your device model and system image then click **Finish**
  - Run your newly created virtual device by clicking the play button (make sure you have enough disk space to run the emulator)
    ![Run_emulator](readme_images/run_emulator.jpg)
    <img src="readme_images/emulator.png" alt="emulator" width="200"/>
  - Once the emulator is running, make sure your virtual device is connected to your IDE
    - if you're using VScode this is what it looks like when you're connected
      ![vscode_connected](readme_images/vscode_connected.png)
    - if you're using Android Studio this is what it looks like when you're connected
      ![android_studio_connected](readme_images/android_studio_connected.jpg)
  - Run the project from your terminal
    ```sh
    flutter pub run lib/main.dart
    ```

### Building and Downloading the APK

- Building the APK

  - Set the build name by changing 'version' variable in the `pubspec.yaml`

    ```sh
    version: "YOUR_BUILD_NAME"+1
    ```

    - example:
      ```sh
      version: 1.0.0+1
      ```

  - Build the APK by running this code in the terminal
    ```sh
    flutter build apk
    ```

- Downloading the APK

  You can download the Gatherly APK from these links:

  - [Gatherly demo](https://drive.google.com/file/d/1AVLzPtZQcj0mI410Pk_KZ-rHLKg_2wfx/view?usp=sharing)
  - [Gatherly production](https://drive.google.com/file/d/1nO6CxXhHU2iyjBezWEZIoR6OGaHCjxwx/view?usp=sharing)

Alternatively you can access the APK from the release section

- Click the latest release in the github page
  ![releases](readme_images/releases.jpg)
- you can find the APKs for the gatherly at the bottom of the page
  ![apk_images](readme_images/apks.jpg)

Once you've downloaded the APK, run the apk in your phone to install the app