//
//  SettingsView.swift
//  Personal Trainer
//
//  Created by Andrew Acheampong on 5/28/25.
//
import SwiftUI

struct SettingsView: View {
    @AppStorage("useMetric") private var useMetric = false

    var body: some View {
        Form {
            Section(header: Text("Units")
                        .font(.headline)
                        .foregroundColor(.charcoal)
            ) {
                Toggle("Use Metric (kg)", isOn: $useMetric)
                    .tint(.mustard)
            }
        }
        .navigationTitle("Settings")
        .background(Color.ivory)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
