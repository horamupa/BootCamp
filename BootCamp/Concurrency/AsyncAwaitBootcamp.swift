//
//  AsyncAwaitBootcamp.swift
//  BootCamp
//
//  Created by MM on 17.04.2023.
//

import SwiftUI

class AsyncAwaitBootcampViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func fetchData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dataArray.append("Title 1: \(Thread.current)")
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            let newString = "Title 2: \(Thread.current)"
            DispatchQueue.main.async {
                self.dataArray.append(newString)
                self.dataArray.append("Title 3: \(Thread.current)")
            }
        }
    }
    
    func fetchLine() async {
        let line1 = "Line 1: \(Thread.current)"
        self.dataArray.append(line1)
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)

        let line2 = "Line 2: \(Thread.current)"
        await MainActor.run {
            self.dataArray.append(line2)
            
            self.dataArray.append("Line 3: \(Thread.current)")
        }
        
    }
}


struct AsyncAwaitBootcamp: View {
    @StateObject private var vm = AsyncAwaitBootcampViewModel()
    var body: some View {
        List {
            ForEach(vm.dataArray, id: \.self) { data in
                Text(data)
            }
        }
        .onAppear {
//            vm.fetchData()
            Task {
                await vm.fetchLine()
            }
        }
    }
}


struct AsyncAwaitBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AsyncAwaitBootcamp()
    }
}
