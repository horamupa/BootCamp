//
//  ViewBuilderBootcamp.swift
//  BootCamp
//
//  Created by MM on 30.11.2022.
//

import SwiftUI

struct headerView: View {
    
    let title: String
    let description: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            if let description = description {
                Text(description)
                    .font(.callout)
            }
            Rectangle()
                .frame(height: 2)
                .cornerRadius(5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct genericTitleView<Content:View>: View {
    
    let title: String
    let content: Content?
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
     
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            if let content = content {
                content
            }
            Rectangle()
                .frame(height: 2)
                .cornerRadius(5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ViewBuilderBootcamp: View {
    var body: some View {
        VStack {
            headerView(title: "Bid Deal", description: nil)
            genericTitleView(title: "Third") {
                Text("Go baby, GO!")
            }
            Spacer()
        }
        .padding()
    }
}

struct ViewBuilderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewBuilderBootcamp()
    }
}
