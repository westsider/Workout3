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

struct TimerCountdownFormatStyle: FormatStyle {
    func format(_ value: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: TimeInterval(value)) ?? ""
    }
}

extension FormatStyle where Self == TimerCountdownFormatStyle {
    static var timerCountdown: TimerCountdownFormatStyle { TimerCountdownFormatStyle() }
}

class PlaceHolders {
    static func priotDate() -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.date(from: "2023/02/01 22:31") ?? Date()
    }
}

extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
}
