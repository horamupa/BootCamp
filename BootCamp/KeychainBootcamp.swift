//
//  KeychainBootcamp.swift
//  BootCamp
//
//  Created by MM on 20.06.2023.
//

import SwiftUI

enum KeychainErrors: Error {
    case duplicateItem
    case unknown(status: OSStatus)
}

final class KeychainManager {
    static func save(email: String, password: Data) throws -> String {
        let query: [CFString:Any] = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrAccount : email,
            kSecValueData: password
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeychainErrors.duplicateItem
        }
        
        guard status == errSecSuccess else {
            throw KeychainErrors.unknown(status: status)
        }
        print("return Saved")
        return "Saved"
    }
    
    static func getPassword(email: String) throws -> Data? {
        let query: [CFString:Any] = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrAccount : email,
            kSecReturnData: kCFBooleanTrue as Any
        ]
        
        var result: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess else {
            throw KeychainErrors.unknown(status: status)
        }
        
        return result as? Data
    }
}

struct KeychainBootcamp: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var status: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Your email", text: $email)
                TextField("Your password", text: $password)
                Button {
                    do {
                        status = try KeychainManager.save(email: email, password: password.data(using: .utf8) ?? Data())
//                        print("this done")
                    } catch {
                        print(error)
                    }
                } label: {
                    Text("Save")
                }
                Button {
                    do {
                        let data = try KeychainManager.getPassword(email: email)
                        status = String(decoding: data ?? Data(), as: UTF8.self)
                        
                    } catch {
                        print(error)
                    }
                } label: {
                    Text("See current password for account")
                }
                Text(status)
                Spacer()
            }
            .textFieldStyle(.roundedBorder)
            .navigationTitle("Keychain Bootcamp")
            .padding()
        }
    }
}

struct KeychainBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        KeychainBootcamp()
    }
}
