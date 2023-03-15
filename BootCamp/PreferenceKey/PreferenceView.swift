//
//  PreferenceView.swift
//  BootCamp
//
//  Created by MM on 15.03.2023.
//

import SwiftUI

struct PreferenceView: View {
    
    @State var text: String = "First text"
    var body: some View {
        NavigationView {
            VStack {
                Text(text)
                    .preference(key: newPrefKey.self, value: "GoGo")
                SecondScreen()
            }
            
        }
        .onPreferenceChange(newPrefKey.self) { value in
            self.text = value
        }
    }
}

struct PreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceView()
    }
}

struct newPrefKey: PreferenceKey {
    static var defaultValue: String = ""
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct SecondScreen: View {
    @State var downloadedData: String = ""
    var body: some View {
        Text("Text From Second Screen")
            .onAppear { fakeDataDownload() }
            .preference(key: newPrefKey.self, value: downloadedData)
    }
    
    
    func fakeDataDownload() {
        DispatchQueue.main.asyncAfter(deadline: .now()+2) { self.downloadedData = "New DownloadedData"
        }
    }
}
