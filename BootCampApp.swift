//
//  BootCampApp.swift
//  BootCamp
//
//  Created by MM on 07.11.2022.
//

import SwiftUI
import Firebase

@main
struct BootCampApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
//            TaskClickMe()
//            ProtocolsBootcamp(myColor: DefaultColorTheme(), myButton: myButton())
//            CoorHomeView()
//            RootView()
//            CoreDataWork()
//                .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
            KeychainBootcamp()
        }
    }
}
