//
//  CustomTransitions.swift
//  BootCamp
//
//  Created by MM on 19.12.2022.
//

import SwiftUI

struct RotateViewModifier: ViewModifier {
    
    let rotation: Double
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
//            .offset(x: rotation !=0 ? UIScreen.main.bounds.width : 0,
//                y: rotation !=0 ? UIScreen.main.bounds.height : 0)
    }
}

extension AnyTransition {
    static var rotating: AnyTransition {
        AnyTransition.modifier(active: RotateViewModifier(rotation: 180), identity: RotateViewModifier(rotation: 0))
    }
}

struct AnyTransitions: View {
    @State private var isShowRectangle = false
    
    var body: some View {
        VStack {
            Spacer()
            if isShowRectangle {
                Rectangle()
                    .frame(width: 250, height: 350)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
//                    .transition(.move(edge: .leading))
//                    .transition(AnyTransition.scale.animation(.easeInOut))
                    .transition(AnyTransition.rotating.animation(.easeInOut))
            }
            Spacer()
            Text("Click me")
                .withDefButtModifier()
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        isShowRectangle.toggle()
                    }
                }
        }
    }
}

struct CustomTransitions_Previews: PreviewProvider {
    static var previews: some View {
        AnyTransitions()
    }
}
