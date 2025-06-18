import SwiftUI

/// Combines user profile details and app settings.
struct ProfileSettingsView: View {
    @EnvironmentObject var viewModel: PlanViewModel
    @AppStorage("name") private var name: String = "John Doe"
    @AppStorage("email") private var email: String = "john.doe@example.com"
    @AppStorage("age") private var age: String = ""
    @AppStorage("height") private var height: String = ""
    @AppStorage("currentWeight") private var storedWeight: String = ""
    @AppStorage("goal") private var storedGoal: String = ""
    @AppStorage("dietaryPreference") private var dietaryPref: String = ""
    @AppStorage("notificationsEnabled") private var notifications = true
    @AppStorage("useMetric") private var useMetric = false

    // For avatar background color
    private let avatarBackgroundColor = Color.brandGreen

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Profile Avatar and Name
                VStack(spacing: 16) {
                    // Avatar Circle with Initials
                    ZStack {
                        Circle()
                            .fill(avatarBackgroundColor)
                            .frame(width: 120, height: 120)
                            .shadow(color: Color.shadowColor, radius: 5, x: 0, y: 2)

                        Text(getInitials(from: name))
                            .font(.barlowCondensed(.bold, size: 48))
                            .foregroundColor(.buttonText)
                    }

                    // Name and Email
                    VStack(spacing: 4) {
                        Text(name)
                            .font(.barlowCondensedTitle())
                            .foregroundColor(.primaryText)

                        Text(email)
                            .font(.barlowCondensedSubheadline())
                            .foregroundColor(.secondaryText)
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 10)

                // Profile Information Form
                VStack {
                    Form {
                        Section("Profile Information") {
                            TextField("Name", text: $name)
                            TextField("Email", text: $email)
                        }

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
                    .frame(minHeight: 600) // Minimum height for the form
                }
            }
        }
        .navigationTitle("Profile")
        .background(Color.ivory.ignoresSafeArea())
    }

    // Helper function to get initials from name
    private func getInitials(from name: String) -> String {
        let components = name.components(separatedBy: " ")
        let initials = components.compactMap { $0.first }
        return String(initials.prefix(2)).uppercased()
    }
}

#Preview {
    ProfileSettingsView()
        .environmentObject(PlanViewModel())
}
