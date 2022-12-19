//
//  ButtonStyle.swift
//  BootCamp
//
//  Created by MM on 19.12.2022.
//

import SwiftUI

struct somePressebleButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
//            .opacity(configuration.isPressed ? 0.8 : 1)
            .brightness(configuration.isPressed ? 0.05 : 0)
    }
}

extension View {
    func makeMyButton() -> some View {
        self
            .buttonStyle(somePressebleButton())
    }
}

struct ButtonStyleBootcamp: View {
    var body: some View {
        VStack {
            Button {
                
            } label: {
                Text("Click me")
                    .withDefButtModifier()
                    .shadow(color: .blue.opacity(0.3), radius: 10, y: 10)
            }
            .buttonStyle(somePressebleButton())
            Button {
                
            } label: {
                Text("Second Button")
                    .withDefButtModifier()
                    .shadow(color: .blue.opacity(0.3), radius: 10, y: 10)
            }
            .makeMyButton()

        }
    }
}

struct ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyleBootcamp()
    }
}
