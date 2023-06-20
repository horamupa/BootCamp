//
//  RootView.swift
//  BootCamp
//
//  Created by MM on 22.05.2023.
//

import SwiftUI

struct RootView: View {
    @State var showSignInView: Bool = false
    var body: some View {
        ZStack {
            NavigationStack {
                SettingsView(showSignInView: $showSignInView)
            }
            .onAppear {
                let authUser = try? AuthBoy.share.getAuthenticatedUser()
                self.showSignInView = authUser == nil
            }
            .fullScreenCover(isPresented: $showSignInView) {
                NavigationStack {
                    AuthenticationView(showSignInView: $showSignInView)
                }
        }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
