//
//  CoordinatorBootcamp.swift
//  BootCamp
//
//  Created by MM on 06.02.2023.
//

import SwiftUI

struct CoordinatorBootcamp: View {
    
    @State private var path = NavigationPath()
//    var coor = Coordinator
    
    var body: some View {
        NavigationView {
            VStack {
                CoorRouter.homeView.view()
                CoordinatorViewBuilder(type: .three)
                HeaderGeneric(title: "Go") {
                    Text("Koshka")
                }
            }
        }
    }
}

struct CoordinatorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatorBootcamp()
    }
}

///  Routs property TransitionStyle
public enum CoorTransitionStyle {
    case push
    case presentModally
    case presentFullscreen
}

/// Set protocol how Router should look like
public protocol CoorRouterProtocol {
    associatedtype V: View
    var transition: CoorTransitionStyle { get }
    
    @ViewBuilder
    func view() -> V
}


enum CoorRouter: CoorRouterProtocol {
    case homeView
    case shopView(shop: String)
    
    var transition: CoorTransitionStyle {
        switch self {
        case .homeView:
            return .push
        case .shopView:
            return .push
        }
    }
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .homeView:
            HomeView()
        case .shopView(shop: let name) :
            ShopView(shop: name)
        }
    }
}


protocol CoordinatorProtocol {
    
    var navigationController: UINavigationController { get }
    
    func start()
    func show(route: CoorRouter)
    func pop()
    func popToRoot()
    func dissmiss()
}

//let BigBoy = Coordinator<CoorRouter>

class Coordinator<Router: CoorRouterProtocol>: ObservableObject {
    let navigationController: UINavigationController
    let startingRoute: Router?
    
    init(navigationController: UINavigationController = .init(), startingRoute: Router? = nil) {
        self.navigationController = navigationController
        self.startingRoute = startingRoute
    }
    
    func start() {
        guard let route = startingRoute else { return }
        show(route)
    }
    
    func show(_ route: Router, animated: Bool = true) {
        let view = route.view()
        let viewWithCoordinator = view.environmentObject(self)
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        
        switch route.transition {
        case .push:
            navigationController.pushViewController(viewController, animated: true)
        case .presentModally:
                    viewController.modalPresentationStyle = .formSheet
                    navigationController.present(viewController, animated: animated)
        case .presentFullscreen:
            viewController.modalPresentationStyle = .fullScreen
            navigationController.present(viewController, animated: animated)
        }
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func dissmiss(animated: Bool = true)  {
        navigationController.dismiss(animated: true) { [weak self] in
            /// because there is a leak in UIHostingControllers that prevents from deallocation
            self?.navigationController.viewControllers = []
        }
    }
}

   
struct ShopView: View {
    let shop: String
    var body: some View {
        Text(shop)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.purple)
            .cornerRadius(10)
    }
}
