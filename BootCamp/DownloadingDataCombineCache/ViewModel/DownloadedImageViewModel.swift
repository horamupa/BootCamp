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
    let manager = ImageCacheManager.share
    let urlString: String
    let keyID: String
    
    init(url: String, key: String) {
        self.urlString = url
        self.keyID = key
        getImage()
    }
        
    /// check for image in cache and download if don't find
    func getImage() {
        if let savedImage = manager.getCache(key: keyID) {
            image = savedImage
        } else {
            DownloadImage()
        }
    }
    
    /// downloading image and saving to cache
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
                guard
                    let self = self,
                    let image = result
                else {
                    print("Error: no image to save or self")
                    return
                }
                self.image = image
                self.manager.addCache(key: self.keyID, image: image)
            })
            .store(in: &cancellables)
        
        isLoading = false
    }
}
