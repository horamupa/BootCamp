//
//  GenericBootcamp.swift
//  BootCamp
//
//  Created by MM on 30.11.2022.
//

import SwiftUI

struct StringModel {
    var info: String?
    
    func removeInfo() -> StringModel {
        StringModel(info: nil)
    }
}

struct GenericModel<T> {
    var info: T?
    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
}

class GenericBootcampViewModel: ObservableObject {
    
    @Published var stringModel = StringModel(info: "Perfect String")
    @Published var data = ["go","go2"]
    @Published var genData = GenericModel(info: true)
}

struct GenericView<T:View>: View {
    
    let title: String
    let info: T
    var body: some View {
        
        VStack {
            Text(title)
            info
        }
    }
}

struct GenericBootcamp: View {
    @StateObject var vm = GenericBootcampViewModel()
    
    var body: some View {
        VStack {
            Text(vm.genData.info?.description ?? "no data")
            Text(vm.stringModel.info ?? "no data")
            
        }
        .onTapGesture {
            vm.stringModel = vm.stringModel.removeInfo()
            vm.genData = vm.genData.removeInfo()
        }
    }
}

struct GenericBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GenericBootcamp()
    }
}
