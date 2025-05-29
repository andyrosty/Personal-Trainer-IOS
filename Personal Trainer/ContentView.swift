//
//  ContentView.swift
//  Personal Trainer
//
//  Created by Andrew Acheampong on 5/28/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: PlanViewModel

     var body: some View {
         TabView {
             NavigationStack {
                 HomeView()
             }
             .tabItem {
                 Label("Home", systemImage: "house.fill")
             }

             NavigationStack {
                 ResultsView()
             }
             .tabItem {
                 Label("Results", systemImage: "list.bullet.clipboard.fill")
             }

             NavigationStack {
                 SettingsView()
             }
             .tabItem {
                 Label("Settings", systemImage: "gearshape.fill")
             }
         }
         .accentColor(.terracotta)
         .font(.body)
         .background(Color.ivory.edgesIgnoringSafeArea(.all))
     }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PlanViewModel())
    }
}
