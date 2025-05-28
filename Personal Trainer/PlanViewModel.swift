//
//  PlanViewModel.swift
//  Personal Trainer
//
//  Created by Andrew Acheampong on 5/28/25.
//

import SwiftUI

@MainActor
class PlanViewModel: ObservableObject {
    // MARK: – Input state
    @Published var weeklyMeals     = DailyMeal.defaultWeek()
    @Published var currentWeight   = ""
    @Published var goal            = ""
    @Published var workoutFrequency = 3

    // MARK: – Response state
    @Published var result: CoachResult?
    @Published var isLoading = false
    @Published var errorMsg: String?

    // MARK: – Submission
    func submit() async {
        // Start loading
        isLoading = true
        errorMsg = nil

        // Build payload
        let input = UserInput(
            weeklyMeals: weeklyMeals,
            currentWeight: currentWeight,
            goal: goal,
            workoutFrequency: workoutFrequency
        )

        // Call network
        do {
            let coach = try await NetworkManager.shared.fetchPlan(input: input)
            result = coach
        } catch {
            errorMsg = error.localizedDescription
        }

        // Stop loading
        isLoading = false
    }
}

