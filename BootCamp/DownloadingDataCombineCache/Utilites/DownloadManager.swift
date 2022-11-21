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
    
    private init() { }
    
    @Published var downloadedData: [ImageModel]? = nil
    var cancellable = Set<Cancellable>
    
    func downloadData() throws {
        guard
        let url = URL(string: "")
        else {
            throw URLError(.badURL)
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(combineHandler)
            .decode(type: [ImageModel].self, decoder: JSONDecoder())
            .sink { compelation in
                switch {
                case .finished:
                    break
                case .failure
                }
                
            } receiveValue: { [weak self] recivedData in
                self?.downloadedData = recivedData
            }
            .

        
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
