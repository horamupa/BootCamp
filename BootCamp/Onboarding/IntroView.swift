//
//  IntroView.swift
//  BootCamp
//
//  Created by MM on 22.12.2022.
//

import SwiftUI

struct IntroView: View {
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1))]),
                center: .topLeading, startRadius: 200, endRadius: 600)
            .ignoresSafeArea()
//            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            if currentUserSignedIn {
                Text("Go to homeView")
            } else {
                OnboardingView()
            }
        }
        
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
