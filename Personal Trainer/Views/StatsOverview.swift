import SwiftUI
import Charts

/// Aggregated stats metrics – weight chart, streak calendar, etc.
struct StatsOverview: View {
    @State private var weightEntries: [WeightEntry] = WeightEntry.mockData
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                weightChart
                
                streakSection
                
                achievementsSection
            }
            .padding()
        }
        .background(Color.ivory.ignoresSafeArea())
        .navigationTitle("Stats")
    }
    
    // MARK: – Components
    private var weightChart: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Weight")
                .font(.title3.bold())
                .foregroundColor(.charcoal)
            
            Chart(weightEntries) {
                LineMark(
                    x: .value("Date", $0.date),
                    y: .value("Weight", $0.weight)
                )
                .foregroundStyle(Color.statsBlue)
                .interpolationMethod(.catmullRom)
            }
            .frame(height: 200)
        }
    }
    
    private var streakSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Workout Streak")
                .font(.title3.bold())
                .foregroundColor(.charcoal)
            Text("🔥 5 days in a row")
                .font(.headline)
                .foregroundColor(.accentOrange)
        }
    }
    
    private var achievementsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Achievements")
                .font(.title3.bold())
                .foregroundColor(.charcoal)
            ForEach(["Completed first workout", "Lost 2 lbs", "Logged meals for a week"], id: \.self) { badge in
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.mustard)
                    Text(badge)
                        .foregroundColor(.slateGray)
                }
            }
        }
    }
}

#Preview {
    StatsOverview()
}

// MARK: – Models
struct WeightEntry: Identifiable {
    let id = UUID()
    let date: Date
    let weight: Double
    
    static var mockData: [WeightEntry] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        return (0..<14).map { offset in
            WeightEntry(date: calendar.date(byAdding: .day, value: -offset, to: today)!,
                        weight: 190 - Double(offset) * 0.3)
        }.reversed()
    }
}