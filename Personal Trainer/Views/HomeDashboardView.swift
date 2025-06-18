import SwiftUI

/// Dashboard landing page shown in the first tab. It surfaces the most important actions for **today**
/// (start workout, view meals, track stats, etc.).
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

                    HStack(spacing: 16) {
                        statsCard
                            .frame(maxWidth: .infinity)

                        estimatedDaysCard
                            .frame(maxWidth: .infinity)
                    }

                    todaysMealsCard

                    quickActions
                }
                .padding()
            }
            .background(Color.ivory.ignoresSafeArea())
            // App is set to always use dark mode in Info.plist
            .navigationBarTitleDisplayMode(.large)
        }
    }

    // MARK: – Components
    private var todaysWorkoutCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Today's Workout")
                .font(.barlowCondensed(.semiBold, size: 24))
                .foregroundColor(.primaryText)

            if todayWorkouts.isEmpty {
                Text("Log in to generate workout")
                    .font(.barlowCondensedBody())
                    .foregroundColor(.secondaryText)
            } else {
                ForEach(todayWorkouts, id: \.self) { item in
                    Text("• \(item)")
                        .font(.barlowCondensedBody())
                        .foregroundColor(.secondaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.cardBackground))
        .shadow(color: Color.shadowColor, radius: 5, x: 0, y: 2)
    }

    private var startWorkoutCard: some View {
        Button {
            // TODO: navigate to detailed workout view
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 24, weight: .semibold))
                Text("Start Workout")
                    .font(.barlowCondensed(.semiBold, size: 18))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.brandGreen)
            .foregroundColor(.buttonText)
            .cornerRadius(16)
            .shadow(color: Color.shadowColor, radius: 4, x: 0, y: 2)
        }
    }

    private var todaysMealsCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Meal Recommendations")
                .font(.barlowCondensedHeadline())
                .foregroundColor(.primaryText)

            if let todayMeals = viewModel.weeklyMeals.first(where: { $0.day == Date().dayName.lowercased() })?.meals, !todayMeals.isEmpty {
                Text(todayMeals)
                    .font(.barlowCondensedSubheadline())
                    .foregroundColor(.secondaryText)
                    .lineSpacing(4)
            } else {
                Text("Log in to generate meals")
                    .font(.barlowCondensedSubheadline())
                    .foregroundColor(.secondaryText)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.cardBackground))
        .shadow(color: Color.shadowColor, radius: 5, x: 0, y: 2)
    }

    private var statsCard: some View {
           VStack(alignment: .center, spacing: 8) {
               Text("Weight Goal")
                   .font(.barlowCondensed(.medium, size: 18))
                   .foregroundColor(.charcoal)
                   .frame(height: 25)
                   .frame(maxWidth: .infinity, alignment: .center)

               CircularProgressBar(progress: dummyStats)
                   .frame(width: 100, height: 100)
                   .frame(maxWidth: .infinity, alignment: .center)

               Text("\(Int(dummyStats * 100))% reached")
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
               Text("Completion")
                   .font(.barlowCondensed(.medium, size: 18))
                   .foregroundColor(.charcoal)
                   .frame(height: 25)
                   .frame(maxWidth: .infinity, alignment: .center)

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
                VStack(spacing: 8) {
                    Image(systemName: "figure.strengthtraining.traditional")
                        .font(.system(size: 24, weight: .semibold))
                    Text("Log Workout")
                        .font(.barlowCondensed(.semiBold, size: 16))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.accentOrange)
                .foregroundColor(.buttonText)
                .cornerRadius(16)
                .shadow(color: Color.shadowColor, radius: 4, x: 0, y: 2)
            }

            Button {
                // TODO: weight logging action
            } label: {
                VStack(spacing: 8) {
                    Image(systemName: "scalemass.fill")
                        .font(.system(size: 24, weight: .semibold))
                    Text("Log Weight")
                        .font(.barlowCondensed(.semiBold, size: 16))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.brandGreen)
                .foregroundColor(.buttonText)
                .cornerRadius(16)
                .shadow(color: Color.shadowColor, radius: 4, x: 0, y: 2)
            }
        }
    }

    // Dummy stats until backend supplies data
    private var dummyStats: Double {
        // For demo purposes assume 40% stats
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
                .stroke(Color.secondaryText.opacity(0.2), lineWidth: 10)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.statsBlue, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)

            Text("\(Int(progress * 100))%")
                .font(.barlowCondensed(.semiBold, size: 18))
                .foregroundColor(.primaryText)
        }
    }
}

// Simple view with a central number, used for estimated days card
private struct CircularNumberView: View {
    let number: Int

    var body: some View {
        VStack(spacing: 4) {
            Text("\(number)")
                .font(.barlowCondensed(.bold, size: 44))
                .foregroundColor(.terracotta)

                            Text("days estimated")
                .font(.barlowCondensed(.medium, size: 14))
                .foregroundColor(.secondaryText)
        }
    }
}

#Preview {
    HomeDashboardView()
        .environmentObject(PlanViewModel())
}
