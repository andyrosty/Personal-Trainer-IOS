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
             NavWrapper(HomeDashboardView(),  title: "Home",     icon: "house.fill")
             NavWrapper(PlansCalendarView(),  title: "Plans",    icon: "calendar")
             NavWrapper(StatsOverview(),   title: "Stats", icon: "chart.bar.fill")
             NavWrapper(CoachChatView(),      title: "AI Coach", icon: "message.fill")
             NavWrapper(ProfileSettingsView(),title: "Profile",  icon: "person.crop.circle")
         }
         .tint(.brandGreen)               // active tab colour
     }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PlanViewModel())
    }
}

@ViewBuilder
private func NavWrapper<Content: View>(_ view: Content,
                                       title: String,
                                       icon: String) -> some View {
    NavigationStack { view.navigationTitle(title) }
        .tabItem { Label(title, systemImage: icon) }
}
