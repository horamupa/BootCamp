//
//  CombineAdvanced.swift
//  BootCamp
//
//  Created by MM on 10.03.2023.
//

import SwiftUI
import Combine

class CombAdvanceDataManager {
    @Published var downloadedData: [String] = []
    var currentValuePublisher = CurrentValueSubject<String, Never>("Nothing") // have default value
    var passThroughPublisher = PassthroughSubject<Any, Never>() // don't have default value
    
    init() {
        someNetworking()
    }
    
    func someNetworking() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.downloadedData = ["One","Two","Thee"]
        }
    }
}

class CombineAdvancedViewModel: ObservableObject {
    @Published var data: [String] = []
    @Published var currentValueData: String = ""
    var dataManager: CombAdvanceDataManager = CombAdvanceDataManager()
    private var cancellable: Set<AnyCancellable> = []
    init() {
        fetchData()
    }
    
    func fetchData() {
        dataManager.$downloadedData
            .sink { value in
                switch value {
                    
                case .finished:
                    break
                }
            } receiveValue: { [weak self] receivedValue in
                self?.data = receivedValue
            }
            .store(in: &cancellable)

        dataManager.currentValuePublisher
            .sink { [weak self] receivedValue in
                self?.currentValueData = receivedValue
            }
            
            
    }
    
}

struct CombineAdvanced: View {
    @StateObject var vm = CombineAdvancedViewModel()
   
    
    var body: some View {
        VStack{
            ForEach(vm.data, id: \.self) {
                Text($0)
                    .font(.largeTitle)
                    .fontWeight(.black)
            }
            Text(vm.currentValueData)
                .font(.title)
                .fontWeight(.light)
        }
    }
}

struct CombineAdvanced_Previews: PreviewProvider {
    static var previews: some View {
        CombineAdvanced()
    }
}
