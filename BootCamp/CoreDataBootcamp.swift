//
//  CoreDataBootcamp.swift
//  BootCamp
//
//  Created by MM on 07.11.2022.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    @Published var fruits: [FruitEntity] = []
    @Published var text: String = ""
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        fetchCoreData()
    }
    
    func fetchCoreData() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do {
            fruits = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching \(error)")
        }
    }
    
    func addData(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func updateData(entity: FruitEntity) {
        let oldName = entity.name ?? "No name"
        entity.name = oldName + " ! ! !"
        saveData()
    }
    
    func deleteData(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = fruits[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchCoreData()
        } catch let error {
            print("Error saving \(error)")
        }
    }
    
}

struct CoreDataBootcamp: View {
    @StateObject var vm = CoreDataViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Add a fruit...", text: $vm.text)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                Button {
                    guard !vm.text.isEmpty else { return }
                    vm.addData(text: vm.text)
                    vm.text = ""
                } label: {
                    Text("Add this fruit")
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                List {
                    ForEach(vm.fruits) { fruit in
                        Text(fruit.name ?? "No Fruit")
                            .onTapGesture {
                                vm.updateData(entity: fruit)
                            }
                    }
                    .onDelete(perform: vm.deleteData)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Fruits")
        }
    }
}

struct CoreDataBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootcamp()
    }
}
