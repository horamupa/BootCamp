////
////  CoordinatorTabView.swift
////  BootCamp
////
////  Created by MM on 21.03.2023.
////
//
//import SwiftUI
//
//enum TabBarItem {
//    case home
//    case heart
//    case cart
//}
//
//struct TabBarView: View {
//    @EnvironmentObject var coordinator: Coordinator
//    @State var tabSelection: TabBarItem = .home
//
//    var body: some View {
//    
//////        CustomTabBarContainerView(selection: $tabSelection) {
//////            HomeCoordinatorView(coordinator: coordinator.homeCoordinator)
//////                .tabBarItem(tab: .home, selection: $tabSelection)
//////                .tag(TabBarItem.home)
//////            EmptyView()
//////                .tabBarItem(tab: .heart, selection: $tabSelection)
//////                .tag(TabBarItem.heart)
//////            EmptyView()
//////                .tabBarItem(tab: .cart, selection: $tabSelection)
//////                .tag(TabBarItem.cart)
//////            EmptyView()
//////                .tabBarItem(tab: .dialog, selection: $tabSelection)
//////                .tag(TabBarItem.dialog)
//////            NavigationView {
//////                EmptyView()
//////            }
//////            .tabBarItem(tab: .profile, selection: $tabSelection)
//////            .tag(TabBarItem.profile)
////
////        }
////        .fullScreenCover(isPresented: $coordinator.authManager.isUserNil) {
////            EmptyView()
//        }
//        /*
//        VStack {
//            Text("FullScreenCoverView")
//            Button {
//                coordinator.dismissFullScreenCover()
//            } label: {
//                Text("DismissFullScreenCover")
//            }
//        }
//         */
//    }
//}
//
//struct FullScreenCoverView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            TabBarView()
//        }
//    }
//}
//
