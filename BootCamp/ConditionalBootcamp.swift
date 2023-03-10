//
//  ConditionalBootcamp.swift
//  BootCamp
//
//  Created by MM on 28.12.2022.
//

import SwiftUI

struct ConditionalBootcamp: View {
    
    @State var showCircle: Bool = false
    @State var showRectangle: Bool = false
    var body: some View {
        VStack(spacing: 20) {
            Button {
                showCircle.toggle()
            } label: {
                VStack{
                    Text("Change the Circle")
                        .font(.title2)
                    Text("Circle state: \(showCircle.description)")
                }
                .foregroundColor(.black)
            }
            
            if !showCircle {
                Circle()
                    .foregroundColor(.blue)
                    .frame(width: 100, height: 100)
            } else if showRectangle {
                Rectangle()
                    .frame(width: 100, height: 100)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 200, height: 100)
            }
            
            Button {
                showRectangle.toggle()
            } label: {
                VStack{
                    Text("Change the Rectangle")
                        .font(.title2)
                    Text("Rectangle state: \(showRectangle.description)")
                }
                .foregroundColor(.black)
            }
        }
    }
}

struct ConditionalBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ConditionalBootcamp()
    }
}
