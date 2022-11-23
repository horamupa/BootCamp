//
//  DataRowView.swift
//  BootCamp
//
//  Created by MM on 22.11.2022.
//

import SwiftUI

struct DownloadImagesRow: View {
    
    var image: ImageModel
    
    var body: some View {
        HStack {
            DownloadImageView(url: image.url, key: "\(image.id)")
                .frame(width: 75, height: 75)
            VStack(alignment: .leading) {
                Text(image.title)
                    .font(.headline)
                Text(image.thumbnailUrl)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct DataRowView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadImagesRow(image: dev.devImage)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
