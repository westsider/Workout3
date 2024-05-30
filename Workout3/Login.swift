//
//  Login.swift
//  Workout3
//
//  Created by Warren Hansen on 5/30/24.
//

import SwiftUI

struct Login: View {
    var body: some View {
        ZStack {

            Image("pfAll")
                .resizable()

            Text("\(Date().formatted(date: .abbreviated, time: .omitted))")
                .font(.title)
                .bold()
                .foregroundStyle(.white)
                .background(.black)
                .offset(CGSize(width: 0.0, height: -290))
               
        } 
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea()
    }
}

#Preview {
    Login()
}
