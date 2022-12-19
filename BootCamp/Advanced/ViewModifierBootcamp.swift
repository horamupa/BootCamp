//
//  ViewModifierBootcamp.swift
//  BootCamp
//
//  Created by MM on 19.12.2022.
//

import SwiftUI

struct DefaultButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.headline)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(.blue)
            .cornerRadius(10)
            .padding()
    }
}

extension View {
    func withDefButtModifier() -> some View {
        self
            .modifier(DefaultButtonModifier())
    }
}

struct ViewModifierBootcamp: View {
    var body: some View {
        VStack {
            
            Text("You never know")
                .withDefButtModifier()
            
            Text("Hello, World!")
                .foregroundColor(.white)
                .font(.headline)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(.blue)
                .cornerRadius(10)
                .padding()
            
            Text("Hello, People")
                .modifier(DefaultButtonModifier())
        }
        
    }
}

struct ViewModifierBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifierBootcamp()
    }
}
