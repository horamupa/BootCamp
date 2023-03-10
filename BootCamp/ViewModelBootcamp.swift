//
//  ViewModelBootcamp.swift
//  BootCamp
//
//  Created by MM on 03.02.2023.
//

import SwiftUI


// @StateObject -> USE THIS ON CREATION / INIT
// @ObservedObject -> USE THIS FOR SUBVIEWS


struct FruitModel: Identifiable {
    let id = UUID().uuidString
    let name: String
    let count: Int
}

class ViewModelBootcampViewModel: ObservableObject {
    @Published var fruitArray: [FruitModel] = []
    
    init() {
        getFruits()
    }
    
    func deleteFruit(index: IndexSet) {
        fruitArray.remove(atOffsets: index)
    }
    
    func getFruits() {
        let fruit1 = FruitModel(name: "Orange", count: 1)
        let fruit2 = FruitModel(name: "Banana", count: 3)
        let fruit3 = FruitModel(name: "Watermelon", count: 4)
        fruitArray.append(fruit1)
        fruitArray.append(fruit2)
        fruitArray.append(fruit3)
    }
}

struct ViewModelBootcamp: View {
    @StateObject var vm = ViewModelBootcampViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.fruitArray) { fruit in
                    HStack {
                        Text("\(fruit.count)")
                            .foregroundColor(.red)
                        Text(fruit.name)
                            .font(.headline)
                    }
                }
                .onDelete { IndexSet in
                    vm.deleteFruit(index: IndexSet)
                }
            }
            .listStyle(.grouped)
            .navigationTitle("FruitList")
            .toolbar {
                NavigationLink {
                    SecondView(vm: vm)
                } label: {
                    Text("SecondView")
                }
            }
        }
    }
}

struct SecondView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: ViewModelBootcampViewModel
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            Button {
                dismiss()
            } label: {
                Text("RETURN")
                    .padding()
                    .foregroundColor(.white)
            }
            VStack {
                ForEach(vm.fruitArray) { fruit in
                    Text(fruit.name)
                }
            }

        }
    }
}

struct ViewModelBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewModelBootcamp()
    }
}
