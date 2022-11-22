//
//  HomeView.swift
//  BootCamp
//
//  Created by MM on 21.11.2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    if vm.imageArray.count > 0 {
                        ForEach(vm.imageArray) { image in
                            DownloadImagesRow(image: image)
                        }
                    } else {
                        VStack {
                            Text("Loading data...")
                                .font(.headline)
                            ProgressView()
                        }
                    }
                }
                .navigationTitle("DownloadCacheModel")
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
