import SwiftUI

/// Combines user profile details and app settings.
struct ProfileSettingsView: View {
    @EnvironmentObject var viewModel: PlanViewModel
    @AppStorage("age") private var age: String = ""
    @AppStorage("height") private var height: String = ""
    @AppStorage("currentWeight") private var storedWeight: String = ""
    @AppStorage("goal") private var storedGoal: String = ""
    @AppStorage("dietaryPreference") private var dietaryPref: String = ""
    @AppStorage("notificationsEnabled") private var notifications = true
    @AppStorage("useMetric") private var useMetric = false

    var body: some View {
        Form {
            Section("Personal Info") {
                TextField("Age", text: $age)
                    .keyboardType(.numberPad)
                TextField("Height (\(useMetric ? "cm" : "ft"))", text: $height)
                TextField("Current Weight (\(useMetric ? "kg" : "lbs"))", text: $storedWeight)
                TextField("Goal", text: $storedGoal)
            }

            Section("Dietary Preferences") {
                TextField("Restrictions (e.g. Vegan)", text: $dietaryPref)
            }

            Section("Notifications") {
                Toggle("Enable reminders", isOn: $notifications)
                    .tint(.brandGreen)
                Stepper("Frequency: 2 / day", onIncrement: {}, onDecrement: {}) // placeholder
            }

            Section("Units") {
                Toggle("Use Metric (kg/cm)", isOn: $useMetric)
                    .tint(.mustard)
            }

            Section {
                Button(role: .destructive) {
                    // TODO: logout / delete account
                } label: {
                    Text("Log Out")
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .navigationTitle("Profile")
        .background(Color.ivory)
    }
}

#Preview {
    ProfileSettingsView()
        .environmentObject(PlanViewModel())
} 