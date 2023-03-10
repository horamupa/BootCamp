////
////  NavigationStackBootC.swift
////  BootCamp
////
////  Created by MM on 06.02.2023.
////
//
//import SwiftUI
//
//struct NavigationStackBootC: View {
//    
//    @State private var contentCreators: [ContentCreator] = ContentCreator.preview
//    @State private var creatorStack: [ContentCreator] = []
//    
//    var body: some View {
//        NavigationStack(path: $creatorStack) {
//            VStack {
//                List(contentCreators) { creator in
//                    //Тут создаём View линка
//                    NavigationLink(creator.name, value: creator)
//                } //Тут создаём View самого линка
//                .navigationDestination(for: ContentCreator.self) { creator in
//                    VStack {
//                        Text(creator.name)
//                    }
//                }
////                Button("Navigate 3 times") {
////                    creatorStack = [
////                        contentCreators[0], contentCreators[1], contentCreators[2], contentCreators[3]
////                    ]
////                }
//            }
//        }
//    }
//}
//
//struct NavigationStackBootC_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStackBootC()
//    }
//}
//
//struct ContentCreator: Identifiable, Hashable {
//    let id = UUID().uuidString
//    
//    let name: String
//    
//    static let preview: [ContentCreator] = [
//        .init(name: "Misha"),
//        .init(name: "Ivan"),
//        .init(name: "Roma"),
//        .init(name: "Kostya")
//    ]
//}
//
//enum FrameWork: String, Hashable, CaseIterable {
//    case SwiftUI, UIKit, AppKit, WatchKit
//}
