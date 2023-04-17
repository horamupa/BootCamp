//
//  AsyncCombine.swift
//  BootCamp
//
//  Created by MM on 15.04.2023.
//

import SwiftUI
import Combine

class AsyncImageLoader: ObservableObject {
    let url = URL(string: "https://picsum/photos/200")!
    
    func handleCompeletion(_ data: Data?, _ response: URLResponse?) -> UIImage? {
        guard
            let data = data,
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        return image
    }
    
    func downloadWithCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleCompeletion)
            .mapError{$0}
            .eraseToAnyPublisher()
    }
}

class AsyncCombineViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    var loader = AsyncImageLoader()
    var cancellables = Set<AnyCancellable>()
    
    func fetchImage() {
        loader.downloadWithCombine()
            .sink { _ in
                
            } receiveValue: { [weak self] image in
                self?.image = image
            }
            .store(in: &cancellables)

    }
}

struct AsyncCombineView: View {
    @StateObject var vm = AsyncCombineViewModel()
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
            }
        }
    }
}

struct Async_Combine_Previews: PreviewProvider {
    static var previews: some View {
        AsyncCombineView()
    }
}
