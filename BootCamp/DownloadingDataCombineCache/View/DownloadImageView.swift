//
//  FetchedImageView.swift
//  BootCamp
//
//  Created by MM on 22.11.2022.
//

import SwiftUI

struct DownloadImageView: View {
    
    @StateObject var loader: DownloadedImageViewModel
    
    init(url: String) {
        _loader = StateObject(wrappedValue: DownloadedImageViewModel(url: url))
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                    Image(uiImage: image)
                        .resizable()
                        .clipShape(Circle())
            }
        }
    }
}

struct FetchedImageView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadImageView(url: dev.devImage.url)
            .frame(width: 75, height: 75)
            .previewLayout(.sizeThatFits)
    }
}
