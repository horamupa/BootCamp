//
//  CombineAdvancedPart2.swift
//  BootCamp
//
//  Created by MM on 11.03.2023.
//

import SwiftUI
import Combine

class CombAdvanceDataManager2 {
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
                
                if x == downloadedNumbers.indices.last {
                    self.passThroughPublisher.send(completion: .finished)
                }
            }
        }
    }
}

class CombineAdvancedViewModel2: ObservableObject {
    @Published var data: [String] = []
    @Published var currentValueData: String = ""
    @Published var numbersCounting: [String] = []
    @Published var error: String = ""
    var dataManager: CombAdvanceDataManager2 = CombAdvanceDataManager2()
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
        /*
//            .first()
//            .first(where: { $0 > 4 } )
//            .tryFirst(where: { item in // fake error
//                if item == 3 {
//                    throw URLError(.badServerResponse)
//                }
//                return item > 4
//            })
//            .last()
//            .last(where: { $0 > 4 })
//            .tryLast(where: { item in
//                if item == "bad item" {
//                    throw URLError(.badServerResponse)
//                }
//                return item < 2
//            })
//            .dropFirst() // Пропускает первое дефолтное значение
//            .dropFirst(3) // Пропустит первые 3 значения
//            .drop(while: { $0 < 3 }) // пропускает, пока внутреннее значение не будет отвечать условиям
//            .dropFirst()
//            .tryDrop(while: { int in
//                if int == 13 {
//                    throw URLError(.badServerResponse)
//                }
//                return int < 6
//            })
//            .prefix(4) // дай мне 4 первых значения
            .prefix(while: { int in
                int < 5
            })// присылает паблишер, пока значение меньше 5, но можно использовать в приложении, типо присылай дату пока не сообщение новое для пользователей и тд.
            .output(at: 2) // пришлёт значение с индексом 2
            .output(in: 0..<4) // Пришлёт радиус значений.
        */
        //Mathematic Operators
        /*
//            .max() // из за того, что у нас пугликуются числи, поэтому доступно
//            .max(by: { int1, int2 in
//                int1 < int2
//            })
//            .tryMax(by: { })
//            .min(by: <#T##(Int, Int) -> Bool#>)
//            .tryMin(by: <#T##(Int, Int) throws -> Bool#>)
         */
        // Filtering
        /*
//            .map { String($0) }
//            .tryMap({ int in
//                if int == 6 {
//                    throw URLError(.badServerResponse)
//                }
//                return String(int)
//            })
//            .compactMap({ int in
//                if int == 5 {
//                    return nil
//                }
//                return String(int)
//            }) // Игнорировать определённое значение и продолжить
//            .tryCompactMap(<#T##transform: (Int) throws -> T?##(Int) throws -> T?#>)
//            .filter({
//                ($0 > 3) && ($0 < 7)
//            }) // пропускаем только определённые значения
//            .tryFilter()
//            .removeDuplicates() // не публиковать дубли которые идут подряд
//            .removeDuplicates(by: { int1, int2 in
//                return int1 == int2
//            })
//            .tryRemoveDuplicates(by: <#T##(Int, Int) throws -> Bool#>)
//            .replaceNil(with: 5) // ВАЖНО заменить nil если пришёл на любое значение
//            .replaceEmpty(with: 5) // Если пришла пустая аррей - чем заменить.
//            .replaceError(with: "Default Value") // Заменяет ошибку на значение в потоке!
//            .scan(0, { dataDef, dataNew in
//                return dataDef + dataNew
//            }) // начиная с нуля он сейвит значение в dataDef и dataNew это следующая дата в потоке
//            .scan(0, {$0 + $1})
//            .scan(0, +)
//            .tryScan(<#T##initialResult: T##T#>, <#T##nextPartialResult: (T, Int) throws -> T##(T, Int) throws -> T#>)
//            .reduce(0, { dataOld, dataNew in
//                dataOld + dataNew
//            }) // публикует только одно финальное значение
//            .collect() // не публикует, пока не заколектит всё дату AFTER .map
//            .collect(3) // публикует дату пакетами по 3 штуки AFTER .map
//            .allSatisfy({ $0 < 15  }) // ВСЕ итемы должны соответствовать правилу
//            .tryAllSatisfy(<#T##predicate: (Int) throws -> Bool##(Int) throws -> Bool#>)
        */
            .map { String($0) }
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error): // passing error to the @Published
                    self?.error = "Error PassThrough in VM: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] value in
//                self?.numbersCounting.append(contentsOf: value)
                self?.numbersCounting.append(value)
            })
//            .sink { [weak self] int in
//                self?.numbersCounting.append(int)
//            }
            .store(in: &cancellable)

            
    }
    
}

struct CombineAdvanced2: View {
    @StateObject var vm = CombineAdvancedViewModel2()
   
    
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

struct CombineAdvanced2_Previews: PreviewProvider {
    static var previews: some View {
        CombineAdvanced2()
    }
}
