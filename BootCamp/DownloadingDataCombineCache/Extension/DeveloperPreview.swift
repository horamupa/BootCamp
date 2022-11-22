//
//  PreviewProviderExtension.swift
//  BootCamp
//
//  Created by MM on 22.11.2022.
//

import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        DeveloperPreview.share
    }
    
}

class DeveloperPreview {
    
    static let share = DeveloperPreview()
    
    let devImage = ImageModel(id: 1, title: "Blank title", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/150/92c952")
    
}
