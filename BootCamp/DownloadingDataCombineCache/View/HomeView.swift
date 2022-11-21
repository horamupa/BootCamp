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
                VStack {
                    ForEach(vm.imageArray) { image in
                        
                    }
                }
            }
            .navigationTitle("DownloadCacheModel")
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
