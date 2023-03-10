//
//  ViewBuilder2BootC.swift
//  BootCamp
//
//  Created by MM on 06.02.2023.
//

import SwiftUI

struct ViewBuilder2BootC: View {
    var body: some View {
        HeaderGeneric(title: "Go") {
            Text("Pipiska")
        }
    }
}

struct ViewBuilder2BootC_Previews: PreviewProvider {
    static var previews: some View {
        ViewBuilder2BootC()
    }
}

struct HeaderGeneric<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack {
            Text(title)
            content
        }
    }
}

struct LocalViewBuilder<Content:View>:View {
    let content: Content
    var body: some View {
        content
    }
}

struct CoordinatorViewBuilder: View {
    enum ViewType { case one, two, three }
    let type: ViewType
    
    var body: some View {
        VStack {
            viewChoose
        }
    }
    
    @ViewBuilder private var viewChoose: some View {
        switch type {
        case .one:
            Text("Hi")
        case .two:
            Text("Twoo")
        case .three:
            Text("Three")
        }
        
//        if type == .one {
//            Text("Hi")
//        } else if type == .two {
//            Text("Twoo")
//        } else if type == .three {
//
//        }
    }
}
