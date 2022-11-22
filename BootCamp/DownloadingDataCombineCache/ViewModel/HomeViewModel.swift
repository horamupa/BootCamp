//
//  HomeViewModel.swift
//  BootCamp
//
//  Created by MM on 21.11.2022.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var imageArray: [ImageModel] = []
    
    var manager = DownloadManager.shared
    var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchImages()
    }
    
    func fetchImages() {
        manager.$downloadedData
            .sink { [weak self] (result) in
                self?.imageArray = result
            }
            .store(in: &cancellables)
    }
}
