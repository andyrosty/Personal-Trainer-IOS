import SwiftUI

/// Shows the 7-day workout / meal plan in a calendar-like grid.
/// For now, data is mocked from `PlanViewModel` until we get a richer model from the backend.
struct PlansCalendarView: View {
    @EnvironmentObject var viewModel: PlanViewModel
    @State private var selectedDay: String = Date().dayName

    var body: some View {
        VStack(alignment: .leading) {
            header

            calendarScroll

            Divider().padding(.vertical)

            detailsSection

            Spacer()
        }
        .padding()
        .background(Color.ivory.ignoresSafeArea())
        .navigationTitle("Plans")
    }

    private var header: some View {
        HStack {
            Text("This Week")
                .font(.title2.bold())
                .foregroundColor(.charcoal)
            Spacer()
            Button {
                // TODO: open modal to request plan adjustment
            } label: {
                Label("Adjust", systemImage: "slider.horizontal.3")
            }
            .font(.subheadline.bold())
            .foregroundColor(.accentOrange)
        }
    }

    private var calendarScroll: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(viewModel.weeklyMeals) { daily in
                    let isSelected = daily.day == selectedDay.lowercased()
                    VStack {
                        Text(daily.day.prefix(3).uppercased())
                            .font(.caption)
                        Circle()
                            .fill(isSelected ? Color.brandGreen : Color.slateGray.opacity(0.3))
                            .frame(width: 10, height: 10)
                    }
                    .padding(8)
                    .background(isSelected ? Color.brandGreen.opacity(0.2) : Color.clear)
                    .cornerRadius(8)
                    .onTapGesture { selectedDay = daily.day }
                }
            }
        }
    }

    private var detailsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Details for \(selectedDay.capitalized)")
                .font(.headline)
                .foregroundColor(.charcoal)

            // Workout placeholder
            Text("Workout: \(viewModel.result?.workoutPlan.first ?? "–")")
                .font(.subheadline)
                .foregroundColor(.slateGray)

            // Meals placeholder – fetch from weeklyMeals quick matching
            if let meals = viewModel.weeklyMeals.first(where: { $0.day == selectedDay.lowercased() })?.meals,
               !meals.isEmpty {
                Text("Meals: \(meals)")
                    .font(.subheadline)
                    .foregroundColor(.slateGray)
            } else {
                Text("No meals logged yet")
                    .font(.subheadline)
                    .italic()
            }
        }
    }
}

#Preview {
    PlansCalendarView()
        .environmentObject(PlanViewModel())
}

// MARK: – Helpers
private extension Date {
    var dayName: String {
        let df = DateFormatter()
        df.dateFormat = "EEEE" // full day name
        return df.string(from: self)
    }
} 