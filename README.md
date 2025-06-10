 # Personal Trainer

 Personal Trainer is a SwiftUI application that helps users generate customized fitness and diet plans based on their current weight, fitness goals, weekly meal preferences, and desired workout frequency. The app sends user inputs to a backend API to fetch personalized workout and diet recommendations.

 ## Features
 - Input current weight and fitness goal
 - Specify weekly meals for each day of the week
 - Select desired workout frequency per week
 - Generate a personalized workout and diet plan via an external API

 ## Requirements
 - iOS 15.0 or later
 - Xcode 15.0 or later
 - Swift 5.7 or later

 ## Installation

 1. Clone the repository:
    ```bash
    git clone https://github.com/andyrosty/Personal-Trainer-IOS.git
    cd Personal-Trainer-IOS
    ```
 2. Open the Xcode project:
    ```bash
    open "Personal Trainer.xcodeproj"
    ```
 3. (Optional) Configure the API endpoint:
    In `NetworkManager.swift`, update the `baseURL` constant to point to your backend.
 4. Build and run the app on the simulator or a device.

 ## Usage

 - Launch the app.
 - In the Home tab, enter your current weight and fitness goal.
 - Set your preferred workout frequency and weekly meals.
 - Tap “Generate Plan” to fetch your personalized plan.
 - Review the generated workout and diet plan in the Results tab.
 - Toggle between metric and imperial units in the Settings tab.

 ## Project Structure

 ```
 .
 ├── Personal Trainer/           # Main app source files
 ├── Personal Trainer.xcodeproj  # Xcode project file
 ├── Personal TrainerTests/      # Unit test target
 ├── Personal TrainerUITests/    # UI test target
 └── README.md                   # Project README
 ```

 ## Contributing

 Contributions are welcome! Feel free to open issues or submit pull requests.