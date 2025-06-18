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
 3. Configure the FastAPI backend endpoint and AWS credentials:
    - The app is configured to use a FastAPI backend hosted on AWS for fitness plan generation.
    - The app uses the endpoint `https://api.example.com/v1/fitness-plan` for generating fitness and diet plans.
    - You need to provide AWS credentials to authenticate with the API.
    - In your app's initialization code (e.g., in `AppDelegate.swift` or `SceneDelegate.swift`), add:
      ```swift
      // Configure AWS credentials
      let credentials = AWSCredentials(
          accessKey: "YOUR_AWS_ACCESS_KEY",
          secretKey: "YOUR_AWS_SECRET_KEY",
          region: "YOUR_AWS_REGION"
      )
      NetworkManager.shared.configure(with: credentials)
      ```
    - **Security Note**: Never hardcode AWS credentials in your app. Use a secure storage solution or a service like AWS Cognito to manage authentication securely. The example above is for demonstration purposes only.
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

 ## Screenshots

 Here are some screenshots of the Personal Trainer app:

 ![Home Dashboard](Personal%20Trainer/Screenshots/Simulator%20Screenshot%20-%20iPhone%2016%20-%202025-06-18%20at%2018.41.48.png)
 *Home Dashboard - Enter your fitness details and preferences*

 ![Workout Plan](Personal%20Trainer/Screenshots/Simulator%20Screenshot%20-%20iPhone%2016%20-%202025-06-18%20at%2018.41.51.png)
 *Personalized Workout Plan*

 ![Diet Plan](Personal%20Trainer/Screenshots/Simulator%20Screenshot%20-%20iPhone%2016%20-%202025-06-18%20at%2018.41.54.png)
 *Customized Diet Recommendations*

 ![Coach Chat](Personal%20Trainer/Screenshots/Simulator%20Screenshot%20-%20iPhone%2016%20-%202025-06-18%20at%2018.41.57.png)
 *Coach Chat - Get advice from your virtual fitness coach*

 ![Profile Settings](Personal%20Trainer/Screenshots/Simulator%20Screenshot%20-%20iPhone%2016%20-%202025-06-18%20at%2018.42.00.png)
 *Profile Settings - Customize your app experience*

 ## Contributing

 Contributions are welcome! Feel free to open issues or submit pull requests.
