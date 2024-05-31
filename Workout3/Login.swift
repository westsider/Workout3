//
//  Login.swift
//  Workout3
//
//  Created by Warren Hansen on 5/30/24.
//

import SwiftUI

struct Login: View {
    @State var dateNow: Date = Date()
    var body: some View {
        ZStack {
            Image("pfAll")
                .resizable()

            Text("\(dateNow.formatted(date: .abbreviated, time: .omitted))")
                .font(.system(size: 28, design: .serif)).fontWeight(.heavy)
                .foregroundStyle(.white)
                .background(.black)
                .offset(CGSize(width: 0.0, height: -290))
               
        } 
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea()
        .onAppear() {
            dateNow = Date()
        }
    }
}

#Preview {
    Login()
}
