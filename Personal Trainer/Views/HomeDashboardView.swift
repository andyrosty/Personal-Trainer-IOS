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

                    HStack(spacing: 16) {
                        progressCard
                            .frame(maxWidth: .infinity)

                        estimatedDaysCard
                            .frame(maxWidth: .infinity)
                    }

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
                .font(.barlowCondensed(.semiBold, size: 24))
                .foregroundColor(.charcoal)

            if todayWorkouts.isEmpty {
                Text("Log in to generate workout")
                    .font(.barlowCondensedBody())
                    .foregroundColor(.slateGray)
            } else {
                ForEach(todayWorkouts, id: \.self) { item in
                    Text("• \(item)")
                        .font(.barlowCondensedBody())
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
                    .font(.barlowCondensed(.medium, size: 16))
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.brandGreen.opacity(0.9))
            .foregroundColor(.ivory)
            .cornerRadius(12)
        }
    }

    private var todaysMealsCard: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Meal Recommendations")
                .font(.barlowCondensedHeadline())
                .foregroundColor(.charcoal)

            if let todayMeals = viewModel.weeklyMeals.first(where: { $0.day == Date().dayName.lowercased() })?.meals, !todayMeals.isEmpty {
                Text(todayMeals)
                    .font(.barlowCondensedSubheadline())
                    .foregroundColor(.slateGray)
            } else {
                Text("Log in to generate meals")
                    .font(.barlowCondensedSubheadline())
                    .foregroundColor(.slateGray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.secondarySystemBackground)))
        .shadow(radius: 4)
    }

    private var progressCard: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("Weight Goal")
                .font(.barlowCondensedHeadline())
                .foregroundColor(.charcoal)
                .frame(height: 25)
                .frame(maxWidth: .infinity, alignment: .center)

            CircularProgressBar(progress: dummyProgress)
                .frame(width: 100, height: 100)
                .frame(maxWidth: .infinity, alignment: .center)

            Text("\(Int(dummyProgress * 100))% reached")
                .font(.barlowCondensedCaption())
                .foregroundColor(.slateGray)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.secondarySystemBackground)))
        .shadow(radius: 4)
        .frame(height: 190)
    }

    private var estimatedDaysCard: some View {
        VStack(spacing: 8) {
            Text("Estimated Days")
                .font(.barlowCondensedHeadline())
                .foregroundColor(.charcoal)
                .frame(height: 25)
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()

            CircularNumberView(number: estimatedDaysUntilGoal)
                .frame(maxWidth: .infinity, alignment: .center)

            Spacer()

        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.secondarySystemBackground)))
        .shadow(radius: 4)
        .frame(height: 190)
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
                        .font(.barlowCondensed(.medium, size: 16))
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
                        .font(.barlowCondensed(.medium, size: 16))
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.brandGreen)
                .foregroundColor(.ivory)
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

    private var estimatedDaysUntilGoal: Int {
        viewModel.result?.estimateDays ?? 14
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

// MARK: – Circular progress
private struct CircularProgressBar: View {
    var progress: Double   // 0…1

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.slateGray.opacity(0.3), lineWidth: 8)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.progressBlue, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-90))

            Text("\(Int(progress * 100))%")
                .font(.barlowCondensedCaption())
                .foregroundColor(.charcoal)
        }
    }
}

// Simple view with a central number, used for estimated days card
private struct CircularNumberView: View {
    let number: Int

    var body: some View {
        VStack(spacing: 2) {
            Text("\(number)")
                .font(.barlowCondensed(.bold, size: 40))
                .foregroundColor(.terracotta)

            Text("remaining")
                .font(.barlowCondensed(.light, size: 12))
                .foregroundColor(.slateGray)
        }
    }
}

#Preview {
    HomeDashboardView()
        .environmentObject(PlanViewModel())
}
