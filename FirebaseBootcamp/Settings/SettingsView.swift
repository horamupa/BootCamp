//
//  SettingsView.swift
//  BootCamp
//
//  Created by MM on 22.05.2023.
//

import SwiftUI

@MainActor
class SettingsViewModel: ObservableObject {
    
    
    func signOut() throws {
        try AuthBoy.share.signOut()
    }
}

struct SettingsView: View {
    @StateObject var vm = SettingsViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        List {
            Button("SignOut") {
                Task {
                    do {
                        try vm.signOut()
                        showSignInView = true
                        print("User SignedOut")
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
            Button("Reset password") {
                
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews:  PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView(showSignInView: .constant(false))
        }
    }
}
