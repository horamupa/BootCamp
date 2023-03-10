//
//  DownloadManager.swift
//  BootCamp
//
//  Created by MM on 21.11.2022.
//

import SwiftUI
import Combine

class DownloadManager: ObservableObject {
    
    static let shared = DownloadManager()
    private let URLPhoto = "https://jsonplaceholder.typicode.com/photos"
    
    private init() {
       downloadData()
    }
    
    @Published var downloadedData: [ImageModel] = []
    var cancellables = Set<AnyCancellable>()
    
    func downloadData() {
        guard
        let url = URL(string: URLPhoto)
        else {
            print("\(URLError(.badURL))")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(combineHandler)
            .decode(type: [ImageModel].self, decoder: JSONDecoder())
            .sink { (compeletion) in
                switch compeletion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error downloading data: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] result in
                self?.downloadedData = result
            }
            .store(in: &cancellables)
    }
    
    func combineHandler(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}
