//
//  HomeCoordinatorView.swift
//  EffectiveMobileTestApp
//
//  Created by MM on 20.03.2023.
//

import SwiftUI

struct HomeCoordinatorView: View {
    
    @StateObject var coordinator: HomeCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .homeView)
                .navigationDestination(for: HomePages.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.present(sheet: sheet)
                }   
        }
        .environmentObject(coordinator)
    }
}

struct HomeCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCoordinatorView(coordinator: HomeCoordinator())
    }
}
