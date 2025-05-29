//
//  Personal_TrainerApp.swift
//  Personal Trainer
//
//  Created by Andrew Acheampong on 5/28/25.
//

import SwiftUI

@main
struct Personal_TrainerApp: App {
    @StateObject private var viewModel = PlanViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
