//
//  tunsCoreData.swift
//  BootCamp
//
//  Created by MM on 19.06.2023.
//

import SwiftUI

struct CoreDataWork: View {
    @State var isNewItem: Bool = false
    var body: some View {
        NavigationStack {
            List {
                
                ForEach(0..<10) { item in
                    ZStack {
                        NavigationLink(destination: MeditationView()) {
                            EmptyView()
                        }
                        .opacity(0)
                        meditationListView
                    }
                }
            }
            .navigationTitle("Meditations")
            
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        isNewItem.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2 )
                    }
                }
            }
            
        }
        .sheet(isPresented: $isNewItem) {
            NavigationStack {
                AddMeditationView()
            }
        }
    }
}

struct CoreDataWork_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataWork()
    }
}


extension CoreDataWork {
    private var meditationListView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Name")
                .font(.system(size: 26, weight: .bold, design: .rounded))
            Text("Email")
            Text("Phone number")
        }
        .font(.callout.bold())
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .topTrailing) {
            Button {
                
            } label: {
                Image(systemName: "star.fill")
                    .font(.title3)
                    .foregroundColor(.gray.opacity(0.3))
            }
            .buttonStyle(.plain)
            
            
        }
    }
}
