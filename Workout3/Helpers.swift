//
//  Helpers.swift
//  Workout3
//
//  Created by Warren Hansen on 5/26/24.
//

import SwiftUI

struct CheckToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Label {
                configuration.label
            } icon: {
                Image(systemName: configuration.isOn ? "star.circle.fill" : "star.circle")
                    .foregroundStyle(configuration.isOn ? Color.accentColor : .primary)
                    .accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
        }
        .buttonStyle(.plain)
    }
}
