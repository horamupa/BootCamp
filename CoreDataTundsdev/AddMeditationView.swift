//
//  AddMeditationView.swift
//  BootCamp
//
//  Created by MM on 19.06.2023.
//

import SwiftUI

struct AddMeditationView: View {
    @Environment(\.dismiss) private  var dismiss
    @State var number: String = ""
    @State var name: String = ""
    @State var favourites = false
    @State var isListent = false
    @State var date: Date = Date.now
    var body: some View {
        List {
            Section("Meditaton") {
                TextField("Number", text: $number)
                    .keyboardType(.numberPad)
                TextField("Name", text: $name)
                    .keyboardType(.namePhonePad)
                DatePicker("Birthday", selection: $date, displayedComponents: [.date])
                    .datePickerStyle(.compact)
            }
            Section("Lesson settings") {
                Toggle("Favourites", isOn: $favourites)
                Toggle("Listent", isOn: $isListent)
            }
        }
        .navigationTitle("Practice")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    dismiss()
                } label: {
                    Text("Done")
                }
            }
            
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
            }
        }
    }
}

struct AddMeditationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddMeditationView()
        }
    }
}
