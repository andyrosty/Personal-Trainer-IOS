//
//  Models.swift
//  Personal Trainer
//
//  Created by Andrew Acheampong on 5/28/25.
//

import Foundation

// MARK: - DailyMeal
// Represents one day’s worth of meals.
struct DailyMeal: Codable, Identifiable {
    var id = UUID()           // for SwiftUI Lists
    var day: String           // e.g. "Monday"
    var meals: [String]       // e.g. ["Jollof rice", "Salad", "Yam and fish"]

    // If your JSON uses snake_case or different keys,
    // uncomment and adjust CodingKeys:
    /*
    enum CodingKeys: String, CodingKey {
        case day
        case meals
    }
    */
}

// Provide a helper to initialize an empty week:
extension DailyMeal {
    static func defaultWeek() -> [DailyMeal] {
        let days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
        return days.map { DailyMeal(day: $0, meals: []) }
    }
}

// MARK: - UserInput
// Payload you send to /fitness-plan
struct UserInput: Codable {
    var weeklyMeals: [DailyMeal]
    var currentWeight: String    // keep as String if you accept "190 lbs" or parse client-side
    var goal: String             // e.g. "Lose 15 lbs"
    var workoutFrequency: Int    // times per week

    enum CodingKeys: String, CodingKey {
        case weeklyMeals    = "weekly_meals"
        case currentWeight  = "current_weight"
        case goal
        case workoutFrequency = "workout_frequency"
    }
}

// MARK: - CoachResult
// Response you get back
struct CoachResult: Codable {
    var workoutPlan: [String]    // e.g. ["Day 1: Squats…", …]
    var dietPlan: [String]       // e.g. ["Day 1: Jollof rice…", …]
    var estimateDays: Int        // e.g. 30

    enum CodingKeys: String, CodingKey {
        case workoutPlan  = "workout_plan"
        case dietPlan     = "diet_plan"
        case estimateDays = "estimate_days"
    }
}
