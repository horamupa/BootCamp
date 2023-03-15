//
//  GeometryPreferenceKey.swift
//  BootCamp
//
//  Created by MM on 15.03.2023.
//

import SwiftUI

struct GeometryPreferenceKey: View {
    
    @State var size: CGSize = CGSize(width: 0, height: 0)
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .frame(width: size.width, height: size.height)
                .background(Color.blue)
                .cornerRadius(10)
                
            Spacer()
            HStack {
                Rectangle()
                GeometryReader { geo in
                    Rectangle()
                        .preference(key: GeometrySizePreferenceKey.self, value: geo.size)
                        .overlay {
                            Text("\(geo.size.width)")
                                .foregroundColor(.white)
                        }
                }
                
                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(GeometrySizePreferenceKey.self) { value in
            self.size = value
        }
    }
}

struct GeometryPreferenceKey_Previews: PreviewProvider {
    static var previews: some View {
        GeometryPreferenceKey()
    }
}

struct GeometrySizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = CGSize(width: 0, height: 0)
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
