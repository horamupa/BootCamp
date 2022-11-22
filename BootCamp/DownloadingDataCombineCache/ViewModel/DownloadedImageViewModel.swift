//
//  FetchedImageViewModel.swift
//  BootCamp
//
//  Created by MM on 22.11.2022.
//

import SwiftUI
import Combine

class DownloadedImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    let urlString: String
    
    init(url: String) {
        self.urlString = url
        DownloadImage()
    }
    
    func DownloadImage() {
        isLoading = true
        
        guard
            let innerURL = URL(string: urlString)
        else {
            isLoading = false
            print("Bad Image URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: innerURL)
            .map({ (data, response) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { [weak self] result in
                self?.image = result
            })
            .store(in: &cancellables)
        
        isLoading = false
    }
}
