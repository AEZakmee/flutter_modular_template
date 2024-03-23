# Flutter template

Template Flutter project using provider with single state, events and actions, following the architecture shown below:

<br/>
<img src="architecture.png" width=800 align=center>
<br/>

## Initial Setup

Before running the project you have to fetch the dependencies and generate the missing file by executing:
```
./run_build_runner_packages
./run_flutter_gen_l10n
```

The project is configured to support two environments: 'dev' and 'prod'. To run the project with a specific flavor, use the command:

```
flutter run --flavor dev/prod
```

## Package Identifiers

The template project has support for two environments: 'dev' and 'prod'. To modify the package identifier:

### Android

Navigate to android/app/build.gradle. Locate the productFlavors section and specify the dev and prod package identifiers as required.

### iOS

Open the project in Xcode and within the Runner/Flutter folder, find configuration files named 'dev' and 'prod'. Update the PRODUCT_BUNDLE_IDENTIFIER with the desired identifier. Adjust the app display name if needed.

Feel free to include additional properties as necessary.

## Firebase Setup

To integrate Firebase into the template project, use the Firebase CLI for Flutter. Note: Firebase files are git-ignored by default

### For local Firebase setup:

Use the flutterfire_configure script in the project directory or perform manual setup by executing the following commands:

```
curl -sL https://firebase.tools | bash
dart pub global activate flutterfire_cli
firebase login
flutterfire configure
```

Ensure you have the required tools installed and follow the authentication steps for Firebase.
The template project utilises most of the firebase packages, so remove those that are not needed.

