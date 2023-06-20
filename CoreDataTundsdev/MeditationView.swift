//
//  MeditationView.swift
//  BootCamp
//
//  Created by MM on 19.06.2023.
//

import SwiftUI

struct MeditationView: View {
    var body: some View {
        List {
            Section("Meditaton") {
                LabeledContent("Number", value: "Lesson Number")
                LabeledContent("Name", value: "Lesson Name")
            }
            Section("Lesson settings") {
                LabeledContent("Favourites", value: "True")
                LabeledContent("isListent", value: "False")
            }
        }
        .navigationTitle("Practice")
    }
}

struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MeditationView()
        }
    }
}
