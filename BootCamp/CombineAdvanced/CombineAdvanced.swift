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
    @Published var numbers: [Int] = []
    var currentValuePublisher = CurrentValueSubject<String, Never>("Nothing") // have default value
    var passThroughPublisher = PassthroughSubject<Int, Never>() // don't have default value
    
    init() {
        someNetworking()
    }
    
    func someNetworking() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.downloadedData = ["One","Two","Thee"]
        }
        
        let downloadedNumbers = Array(0..<11)
        
        for x in downloadedNumbers.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
                self.passThroughPublisher.send(downloadedNumbers[x])
            }
        }
    }
}

class CombineAdvancedViewModel: ObservableObject {
    @Published var data: [String] = []
    @Published var currentValueData: String = ""
    @Published var numbersCounting: [String] = []
    @Published var error: String = ""
    var dataManager: CombAdvanceDataManager = CombAdvanceDataManager()
    private var cancellable: Set<AnyCancellable> = []
    init() {
        fetchData()
    }
    
    func fetchData() {
        dataManager.$downloadedData
            .sink { completion in
                switch completion {
                case.failure(let error):
                    self.error = "Error Data fetching in VM: \(error.localizedDescription)"
                case .finished:
                    break
                }
            } receiveValue: { [weak self] receivedValue in
                self?.data = receivedValue
            }
            .store(in: &cancellable)
        
        
        dataManager.currentValuePublisher
            .sink { [weak self] data in
                self?.currentValueData = data
            }
            .store(in: &cancellable)

        
        dataManager.passThroughPublisher
        //Sequence Operations
//            .first()
//            .first(where: { $0 > 4 } )
            .tryFirst(where: { item in // fake error
                if item == 3 {
                    throw URLError(.badServerResponse)
                }
                return item > 4
            })
            .map { String($0) }
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error): // passing error to the @Published
                    self?.error = "Error PassThrough in VM: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] value in
                self?.numbersCounting.append(value)
            })
//            .sink { [weak self] int in
//                self?.numbersCounting.append(int)
//            }
            .store(in: &cancellable)

            
    }
    
}

struct CombineAdvanced: View {
    @StateObject var vm = CombineAdvancedViewModel()
   
    
    var body: some View {
        ScrollView {
            VStack{
                if !vm.error.isEmpty {
                    Text(vm.error)
                }
                ForEach(vm.data, id: \.self) {
                    Text($0)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                Text(vm.currentValueData)
                    .font(.title)
                    .fontWeight(.light)
                ForEach(vm.numbersCounting, id: \.self) {
                    Text("\($0)")
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
            }
        }
    }
}

struct CombineAdvanced_Previews: PreviewProvider {
    static var previews: some View {
        CombineAdvanced()
    }
}
