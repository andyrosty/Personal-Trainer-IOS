//
//  HomeView.swift
//  Personal Trainer
//
//  Created by Andrew Acheampong on 5/28/25.
//

import SwiftUI

// MARK: – Home (Input Form)
struct HomeView: View {
    @EnvironmentObject var viewModel: PlanViewModel

    var body: some View {
        Form {
            Section(header: Text("Weekly Meals")
                                   .font(.headline)
                                   .foregroundColor(.charcoal)
            ) {
                ForEach($viewModel.weeklyMeals) { $daily in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(daily.day.capitalized)
                            .font(.subheadline)
                            .foregroundColor(.charcoal)
                        
                        // If your DailyMeal.meals is a String:
                        TextField("Meals for \(daily.day)", text: $daily.meals)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding(.vertical, 4)
                }
            }
            Section(header: Text("Your Details")
                        .font(.headline)
                        .foregroundColor(.charcoal)
            ) {
                TextField("Current Weight (lbs)", text: $viewModel.currentWeight)
                    .keyboardType(.decimalPad)
                TextField("Goal (e.g. Lose 15 lbs)", text: $viewModel.goal)
            }

            Section(header: Text("Workout Frequency")
                        .font(.headline)
                        .foregroundColor(.charcoal)
            ) {
                Picker("Times per week", selection: $viewModel.workoutFrequency) {
                    ForEach(1..<8) { i in
                        Text("\(i)×").tag(i)
                    }
                }
                .pickerStyle(.segmented)
                .tint(.olive)
            }

            if viewModel.isLoading {
                ProgressView("Generating…")
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                Button("Generate Plan") {
                    Task { await viewModel.submit() }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.terracotta)
                .foregroundColor(.ivory)
                .cornerRadius(8)
            }

            if let err = viewModel.errorMsg {
                Text(err)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Get Started")
        .background(Color.ivory)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(PlanViewModel())   // ← inject it here
    }
}
