import SwiftUI

/// Dashboard landing page shown in the first tab. It surfaces the most important actions for **today**
/// (start workout, view meals, track progress, etc.).
/// The concrete business logic will be wired in later – for now this acts as a visual placeholder so
/// that navigation flow is complete and designers/devs can iterate quickly.
struct HomeDashboardView: View {
    @EnvironmentObject var viewModel: PlanViewModel
    @State private var showMeals = false
    @State private var quote: String = "Push yourself, because no one else is going to do it for you."

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    todaysWorkoutCard

                    startWorkoutCard

                    todaysMealsCard

                    progressCard

                    quickActions
                }
                .padding()
            }
            .background(Color.ivory.ignoresSafeArea())
        }
    }

    // MARK: – Components
    private var todaysWorkoutCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Today's Workout")
                .font(.custom("BarlowCondensed-Thin", size: 24, relativeTo: .title3))
                .foregroundColor(.charcoal)

            if todayWorkouts.isEmpty {
                Text("No workout generated yet – tap Start Workout below")
                    .font(.body)
                    .foregroundColor(.slateGray)
            } else {
                ForEach(todayWorkouts, id: \.self) { item in
                    Text("• \(item)")
                        .font(.body)
                        .foregroundColor(.slateGray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.secondarySystemBackground)))
        .shadow(radius: 4)
    }

    private var startWorkoutCard: some View {
        Button {
            // TODO: navigate to detailed workout view
        } label: {
            VStack {
                Image(systemName: "play.circle.fill")
                    .font(.title)
                Text("Start Workout")
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.brandGreen.opacity(0.9))
            .foregroundColor(.ivory)
            .cornerRadius(12)
        }
    }

    private var todaysMealsCard: some View {
        DisclosureGroup(isExpanded: $showMeals) {
            VStack(alignment: .leading, spacing: 4) {
                ForEach(viewModel.weeklyMeals) { daily in
                    HStack {
                        Text(daily.day.capitalized)
                            .font(.subheadline.bold())
                            .foregroundColor(.charcoal)
                        Spacer()
                        Text(daily.meals.isEmpty ? "–" : daily.meals)
                            .font(.subheadline)
                            .foregroundColor(.slateGray)
                            .multilineTextAlignment(.trailing)
                    }
                    Divider()
                }
            }
            .padding(.top, 8)
        } label: {
            HStack {
                Text("Meal Recommendations")
                    .font(.title3.bold())
                Spacer()
                Image(systemName: showMeals ? "chevron.up" : "chevron.down")
            }
            .foregroundColor(.charcoal)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.secondarySystemBackground)))
        .shadow(radius: 4)
    }

    private var progressCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Weight Goal Progress")
                .font(.title3.bold())
                .foregroundColor(.charcoal)

            ProgressView(value: dummyProgress)
                .tint(Color.progressBlue)

            Text("\(Int(dummyProgress * 100))% of goal reached")
                .font(.footnote)
                .foregroundColor(.slateGray)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.secondarySystemBackground)))
        .shadow(radius: 4)
    }

    private var quickActions: some View {
        HStack(spacing: 16) {
            Button {
                // TODO: workout logging action
            } label: {
                VStack {
                    Image(systemName: "figure.strengthtraining.traditional")
                        .font(.title)
                    Text("Log Workout")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.accentOrange.opacity(0.9))
                .foregroundColor(.white)
                .cornerRadius(12)
            }

            Button {
                // TODO: weight logging action
            } label: {
                VStack {
                    Image(systemName: "scalemass.fill")
                        .font(.title)
                    Text("Log Weight")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.mustard)
                .foregroundColor(.charcoal)
                .cornerRadius(12)
            }
        }
    }

    // Dummy progress until backend supplies data
    private var dummyProgress: Double {
        // For demo purposes assume 40% progress
        0.4
    }

    // Return workouts containing today's day name or fallback to first element
    private var todayWorkouts: [String] {
        guard let plan = viewModel.result?.workoutPlan else { return [] }
        let dayName = Date().dayName.lowercased()
        // Find any lines that mention today
        let matches = plan.filter { $0.lowercased().contains(dayName) }
        if !matches.isEmpty { return matches }
        // Fallback: assume array is ordered Sun→Sat starting Sunday
        let weekdayIndex = Calendar.current.component(.weekday, from: Date()) - 1 // Sunday = 1
        if weekdayIndex < plan.count { return [plan[weekdayIndex]] }
        return []
    }
}

// Helper
private extension Date {
    var dayName: String {
        let df = DateFormatter()
        df.dateFormat = "EEEE"
        return df.string(from: self)
    }
}

#Preview {
    HomeDashboardView()
        .environmentObject(PlanViewModel())
} 
