//
//  MachedGeometryEffectBootcamp.swift
//  BootCamp
//
//  Created by MM on 21.12.2022.
//

import SwiftUI

struct MachedGeometryEffectBootcamp: View {
    
    @State var isClicked = false
    @Namespace var namespace
    
    var body: some View {
        VStack {
            if !isClicked {
                RoundedRectangle(cornerRadius: 25)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 100, height: 100)
                    
            }
            
            Spacer()
            
            if isClicked {
                RoundedRectangle(cornerRadius: 25)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 300, height: 200)
                    
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.red)
        .onTapGesture {
            withAnimation {
                isClicked.toggle()
            }
        }
    }
}

struct MachedGeometryEffectBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MatchGeometryEffect2()
    }
}

struct MatchGeometryEffect2: View {
    @State var categories = ["Home", "Popular", "Saved"]
    @State var selected = ""
    @Namespace var namespace2
    var body: some View {
        HStack {
            ForEach(categories, id: \.self) { category in
                ZStack {
                    if category == selected {
                    RoundedRectangle(cornerRadius: 10)
                            .matchedGeometryEffect(id: "selectedCategory", in: namespace2)
                            .frame(width: 35, height: 2)
                            .foregroundColor(.red)
                            .offset(y: 15)
                    }
                    Text(category)
                        .foregroundColor(category == selected ? .red : .black)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                selected = category
                            }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 55)
        }
    }
    
}
