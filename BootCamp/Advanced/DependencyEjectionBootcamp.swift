//
//  DependencyEjectionBootcamp.swift
//  BootCamp
//
//  Created by MM on 07.01.2023.
//

import SwiftUI
import Combine

struct PostModel: Codable, Identifiable {
    /*
     {
     "userId": 1,
     "id": 1,
     "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
     "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
     }
     */
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
}


class ProductionDataService {
    
    static let shared = ProductionDataService()
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    
    func getData() -> AnyPublisher<[PostModel], Error> {
         
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
}


class DependencyEjectionViewModel: ObservableObject {
    @Published var postArray: [PostModel] = []
    var cancellabel = Set<AnyCancellable>()
    var dataService: ProductionDataService
    
    
    init(data: ProductionDataService) {
        self.dataService = data
        getData()
    }
    
    func getData() {
        ProductionDataService.shared.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] recivedValue in
                self?.postArray = recivedValue
            }
            .store(in: &cancellabel)

    }
}

struct DependencyEjectionBootcamp: View {
    
    @StateObject var vm: DependencyEjectionViewModel
    
    init(dataServer: ProductionDataService) {
        _vm = StateObject(wrappedValue: DependencyEjectionViewModel(data: dataServer))
    }
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    ForEach(vm.postArray) { item in
                        Text(item.title)
                    }
                }
            }
        }
    }
}

struct DependencyEjectionBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        let dataServ = ProductionDataService()
        DependencyEjectionBootcamp(dataServer: dataServ)
    }
}
