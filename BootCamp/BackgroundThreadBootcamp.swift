//
//  BackgroundThread Bootcamp.swift
//  BootCamp
//
//  Created by MM on 08.11.2022.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    
    @Published var arrayString: [String] = []
    
    func fetchData() {
        DispatchQueue.global().async {
            let newdata = self.downloadData()
            DispatchQueue.main.async {
                self.arrayString = newdata
            }
        }
    }
    
    func downloadData() -> [String] {
        var minArray: [String] = []
        
        for x in (0..<100) {
            minArray.append("number \(x)")
        }
        return minArray
    }
    
}

struct BackgroundThreadBootcamp: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                ForEach(vm.arrayString, id: \.self) { item in
                    Text(item)
                        .foregroundColor(.red)
                        .font(.headline)
                }
            }
        }
    }
}

struct BackgroundThread_Bootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadBootcamp()
    }
}
