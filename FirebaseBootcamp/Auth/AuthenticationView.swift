//
//  AuthView.swift
//  Мёöт
//
//  Created by MM on 22.05.2023.
//

import SwiftUI

struct AuthenticationView: View {
    
    @StateObject var vm = AuthViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        VStack {
            TextField("Email", text: $vm.email)
            TextField("Password", text: $vm.password) //min 6 char
            
            Button("Create User with email") {
                Task {
                    do {
                        try await vm.signUp()
                        showSignInView = false
                        return
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    do {
                        try await vm.signIn()
                        showSignInView = false
                        return
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(showSignInView: .constant(false))
    }
}
