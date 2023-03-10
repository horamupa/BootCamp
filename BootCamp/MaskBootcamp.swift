//
//  MaskBootcamp.swift
//  BootCamp
//
//  Created by MM on 19.01.2023.
//

import SwiftUI

struct MaskBootcamp: View {
    
    @State var rating: Int = 4
    var body: some View {
        ZStack {
            VStack {
                starsView
                starsView2
                    .overlay {
                        overlayView
                            .mask(starsView2)
                    }
            }
        }
    }
    
    private var starsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(rating >= index ? Color.yellow : Color.gray)
                    .onTapGesture {
                        rating = index
                    }
            }
        }
    }
    private var starsView2: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
            }
        }
    }
    
    private var overlayView: some View {
        GeometryReader { geometry in
            Rectangle()
                .frame(width: CGFloat(rating) / 5 * geometry.size.width)
                .foregroundColor(.yellow)
        }
        .allowsHitTesting(false)
    }
}

struct MaskBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MaskBootcamp()
    }
}
