//
//  ProtocolsBootcamp.swift
//  BootCamp
//
//  Created by MM on 07.01.2023.
//

import SwiftUI

struct DefaultColorTheme: ColorThemeProtocol {
    let primary: Color = .blue
    let secondary: Color = .white
    let tertiary: Color = .gray
}

struct SecondaryColorTheme: ColorThemeProtocol {
    let primary: Color = .red
    let secondary: Color = .white
    let tertiary: Color = .green
}

protocol ColorThemeProtocol {
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
}

class myButton: AllRoundButton {
    var text: String = "Protocols are awesome!"
    
    func changeText() {
        self.text = "Protocols are awesome! Yeah!"
        print("Button Pressed")
        print(self.text)
    }
}

class myButtonText: DefaultButtonProtocol {
    let text: String = "Protocols are lame."
}

protocol DefaultButtonProtocol {
    var text: String { get }
}

protocol ButtonChangeTextProtocol {
    func changeText()
}

protocol AllRoundButton: DefaultButtonProtocol, ButtonChangeTextProtocol {
    
}

struct ProtocolsBootcamp: View {
    
    var myColor: ColorThemeProtocol
    @State var myButton: AllRoundButton
    
    
    var body: some View {
        ZStack {
            myColor.tertiary
                .ignoresSafeArea()
            Text(myButton.text)
                .font(.headline)
                .padding()
                .foregroundColor(myColor.secondary)
                .background {
                    myColor.primary
                }
                .cornerRadius(10)
                .onTapGesture {
                    myButton.changeText()
                    self.myButton = self.myButton
                }
        }
        
    }
}

struct ProtocolsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ProtocolsBootcamp(myColor: DefaultColorTheme(), myButton: myButton())
    }
}
