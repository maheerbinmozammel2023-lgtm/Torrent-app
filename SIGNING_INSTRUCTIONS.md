# iOS Code Signing Instructions

To build and run this Flutter application on an iOS device or simulator, you need to set up code signing in Xcode.

Follow these steps:

1.  **Open the iOS project in Xcode:**
    Navigate to the `ios` directory in your project and open the `Runner.xcworkspace` file:
    ```bash
    open ios/Runner.xcworkspace
    ```

2.  **Select the Runner project:**
    In the Xcode project navigator (left sidebar), select the `Runner` project at the very top of the hierarchy.

3.  **Go to Signing & Capabilities:**
    With the `Runner` project selected, navigate to the "Signing & Capabilities" tab in the main content area.

4.  **Select your Team:**
    -   Under the "Team" dropdown, choose your personal team or your organization's Apple Developer Program team.
    -   If you don't have a team set up, you might need to add your Apple ID in Xcode's preferences (Xcode > Settings/Preferences > Accounts).

5.  **Automatic Signing:**
    Ensure that "Automatically manage signing" is checked. Xcode will then attempt to create and manage the necessary provisioning profiles and signing certificates for you.

6.  **Bundle Identifier:**
    Make sure the "Bundle Identifier" matches the one specified in your `Info.plist` and `pubspec.yaml` (e.g., `com.example.torrentApp`). Xcode might automatically adjust it based on your team, or you can manually change it to match if needed.

Once these steps are completed, Xcode should successfully sign your application, allowing you to build and deploy it to your iOS devices.
