//
//  Coordinator.swift
//  BootCamp
//
//  Created by MM on 21.03.2023.
//

import Foundation
import SwiftUI

class CoordinatorObject: ObservableObject {
    @Published var path = NavigationPath()
//    @Published var homeCoordinator: HomeCoordinator!
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    //Services Init
//    var dataManager: any DataServiceProtocol
//    var authManager: AuthService
    
//    init(dataManager: DataService, authManager: AuthService) {
//        self.dataManager = dataManager
//        self.authManager = authManager
//        self.homeCoordinator = HomeCoordinator(mainCoordinator: self)
//    }
    

    func push(_ page: Page ) {
        path.append(page)
    }

    func sheet(_ sheet: Sheet) {
        self.sheet = sheet
    }

    func fullScreenCover(_ fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }

    func pop() {
        self.path.removeLast()
    }

    func popToRoot() {
        self.path.removeLast(path.count )
    }

    func dismissSheet() {
        self.sheet = nil
    }

    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }

    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .none:
            EmptyView()
        }

    }

    @ViewBuilder
    func present(sheet: Sheet) -> some View {
        switch sheet {
        case .none:
            NavigationStack {
                EmptyView()
//                SheetView()
            }
        }
    }

    @ViewBuilder
    func presentFull(fullScreenCover: FullScreenCover) -> some View {
        switch fullScreenCover {
        case .none:
            NavigationStack {
                EmptyView()
//                AuthView()
            }
        }

    }
}

enum Page: String, Identifiable {
    case none

    var id: String {
        self.rawValue
    }
}

enum Sheet: String, Identifiable {
    case none

    var id: String {
        self.rawValue
    }
}

enum FullScreenCover: String, Identifiable {
    case none

    var id: String {
        self.rawValue
    }
}
