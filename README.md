# Gatherly Frontend Mobile

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
    ```

### Running the Project 

- Android Device
    - Enable [Developer options](https://developer.android.com/studio/debug/dev-options)
    - Enable `USB Debugging` in Developer options
    - Plug your device to a computer with a USB cable and allow `USB debugging` if asked
    - Run the project 
        ```sh
        flutter pub run lib/main.dart
- Android Emulator
    - TODO