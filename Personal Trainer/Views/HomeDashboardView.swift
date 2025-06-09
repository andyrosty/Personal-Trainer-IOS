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

                    todaysMealsCard

                    progressCard

                    quickActions

                    quoteCard
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

            Text(viewModel.result?.workoutPlan.first ?? "No workout generated yet – tap below to start")
                .font(.body)
                .foregroundColor(.slateGray)
                .lineLimit(2)

            Button {
                // TODO: navigate to detailed workout view
            } label: {
                Label("Start Workout", systemImage: "play.fill")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.brandGreen)
                    .foregroundColor(.ivory)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.secondarySystemBackground)))
        .shadow(radius: 4)
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
                Text("Today's Meals")
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
        Button {
            // TODO: workout logging action
        } label: {
            VStack {
                Image(systemName: "figure.walk.circle.fill")
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
    }

    private var quoteCard: some View {
        HStack {
            Image(systemName: "quote.opening")
                .font(.title2)
                .foregroundColor(.brandGreen)
            Text(quote)
                .font(.callout)
                .italic()
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.secondarySystemBackground)))
        .shadow(radius: 4)
    }

    // Dummy progress until backend supplies data
    private var dummyProgress: Double {
        // For demo purposes assume 40% progress
        0.4
    }
}

#Preview {
    HomeDashboardView()
        .environmentObject(PlanViewModel())
} 