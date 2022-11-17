//
//  SubscriberBootcamp.swift
//  BootCamp
//
//  Created by MM on 10.11.2022.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    @Published var number = 0
    @Published var text = ""
    @Published var chekMark = false
    
//    var timer: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    init() {
//        getTime()
        chekText()
    }
    
    func chekText() {
        $text
            .sink { text in
                if text.count > 3 {
                    self.chekMark = true
                } else {
                    self.chekMark = false
                }
            }
            .store(in: &cancellables)
    }
    
    func getTime() {
            Timer
                .publish(every: 1, on: .main, in: .common)
                .autoconnect()
                .sink(receiveValue: { [weak self] _ in
                    guard let self = self else { return }
                        self.number += 1
                    if self.number >= 10 {
                        for item in self.cancellables {
                            item.cancel()
                        }
                    }
                    
                })
                .store(in: &cancellables)
        
    }
    
}

struct SubscriberBootcamp: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        Text("\(vm.number)")
            .font(.largeTitle)
        TextField("Gimme some text...", text: $vm.text)
            .padding(.leading)
            .frame(height: 55)
            .font(.headline)
            .padding()
            .overlay {
                ZStack(alignment: .trailing) {
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                        .opacity(vm.chekMark ? 1 : 0)
                    Image(systemName: "cross")
                        .foregroundColor(.red)
                        .opacity(vm.chekMark ? 0 : 1)
                }
            }
    }
}

struct SubscriberBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberBootcamp()
    }
}
