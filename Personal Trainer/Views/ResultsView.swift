//
//  ResultsView.swift
//  Personal Trainer
//
//  Created by Andrew Acheampong on 5/28/25.
//

import SwiftUI

// MARK: – Results Screen
struct ResultsView: View {
    @EnvironmentObject var viewModel: PlanViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let coach = viewModel.result {
                    // Estimate
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Estimated Days to Goal")
                            .font(.title2.weight(.semibold))
                            .foregroundColor(.mustard)
                        Text("\(coach.estimateDays) days")
                            .font(.largeTitle.bold())
                            .foregroundColor(.charcoal)
                    }

                    // Workout Plan
                    Section {
                        Text("Workout Plan")
                            .font(.headline)
                            .foregroundColor(.charcoal)
                        ForEach(coach.workoutPlan, id: \.self) { item in
                            Text(item)
                                .font(.body)
                                .foregroundColor(.slateGray)
                        }
                    }

                    // Diet Plan
                    Section {
                        Text("Diet Plan")
                            .font(.headline)
                            .foregroundColor(.charcoal)
                        ForEach(coach.dietPlan, id: \.self) { item in
                            Text(item)
                                .font(.body)
                                .foregroundColor(.slateGray)
                        }
                    }

                    // Edit Inputs
                    Button("Edit Inputs") {
                        viewModel.result = nil
                    }
                    .padding(.top)
                    .frame(maxWidth: .infinity)
                    .background(Color.olive)
                    .foregroundColor(.ivory)
                    .cornerRadius(8)
                } else {
                    Text("No plan generated yet. Head to the Home tab.")
                        .foregroundColor(.slateGray)
                        .italic()
                }
            }
            .padding()
        }
        .navigationTitle("Your Plan")
        .background(Color.ivory)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
            .environmentObject(PlanViewModel())   // ← inject it here
    }
}
