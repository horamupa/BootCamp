//
//  ScrollViewPrefKey.swift
//  BootCamp
//
//  Created by MM on 15.03.2023.
//

import SwiftUI

struct ScrollViewPrefKey: View {
    
    @State var textOffset: CGFloat = 0
    var body: some View {
        ScrollView {
            VStack {
                upperText
                    .opacity(Double(textOffset) / 63)
                    .overlay {
                        GeometryReader { geo in
                            Text("")
                                .preference(key: TitleOffset.self, value: geo.frame(in: .global).minY)
                        }
                    }
                manyRectangles
            }
            
            .padding()
        }
        .overlay(Text("\(textOffset)"))
        .onPreferenceChange(TitleOffset.self) { value in
            self.textOffset = value
        }
        .overlay(
            overlayView.opacity(textOffset < 40 ? 1 : 0).animation(.easeInOut)
            , alignment: .top)
    }
}

struct ScrollViewPrefKey_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewPrefKey()
    }
}

extension ScrollViewPrefKey {
    private var upperText: some View {
        Text("Gonna be hidden")
            .font(.title)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var manyRectangles: some View {
        ForEach(0..<30) { _ in
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.red.opacity(0.3))
                .frame(width: 200, height: 200)
        }
    }
    
    private var overlayView: some View {
        Text("UpperTitle")
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.blue)
            
    }
}

struct TitleOffset: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
