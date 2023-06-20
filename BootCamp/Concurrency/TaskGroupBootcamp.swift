//
//  TaskGroupBootcamp.swift
//  BootCamp
//
//  Created by MM on 04.06.2023.
//

import SwiftUI

class TaskGroupBootcampDataManager {
    
    func fetchImagesWithTaskGroup() async throws -> [UIImage] {
        
        let urlStrings: [String] = ["https://picsum.photos/300",
                                    "https://picsum.photos/300",
                                    "https://picsum.photos/300",
                                    "https://picsum.photos/300",
                                    "https://picsum.photos/300"]
        
        return try await withThrowingTaskGroup(of: UIImage?.self) { group in
            
            var images: [UIImage] = []
            images.reserveCapacity(urlStrings.count)
            
            for url in urlStrings {
                group.addTask {
                    try? await self.fetchImage(urlString: url)
                }
            }
            
            for try await image in group {
                if let image = image {
                    images.append(image)
                }
            }
            
            return images
        }
        
    }

    func fetchWithAsyncLet() async throws -> [UIImage] {
        
        async let fetchedImg1 = fetchImage(urlString: "https://picsum.photos/300")
        async let fetchedImg2 = fetchImage(urlString: "https://picsum.photos/300")
        async let fetchedImg3 = fetchImage(urlString: "https://picsum.photos/300")
        async let fetchedImg4 = fetchImage(urlString: "https://picsum.photos/300")
        
        let (img1,img2,img3,img4) = await (try fetchedImg1, try fetchedImg2, try fetchedImg3, try fetchedImg4)
        return [img1, img2, img3, img4]
    }
    
    func fetchImage(urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data,_) = try await URLSession.shared.data(from: url)
        if let image = UIImage(data: data) {
            return image
        } else {
            throw URLError(.badURL)
        }
    }
}

class TaskGroupBootcampViewModel: ObservableObject {
    
    @Published var images: [UIImage] = []
    
    //better be injected
    var dataManager = TaskGroupBootcampDataManager()
    
//    init() {
//        getImages()
//    }
    
    func getImages() async {
        if let images = try? await dataManager.fetchWithAsyncLet() {
            self.images.append(contentsOf: images)
        }
    }
    
    func getImagesWithTaskGroup() async {
        if let images = try? await dataManager.fetchImagesWithTaskGroup() {
            self.images.append(contentsOf: images)
        }
    }
}
 
struct TaskGroupBootcamp: View {
    
    @StateObject var vm = TaskGroupBootcampViewModel()
    
    let columns = [GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(vm.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                }
            }
            .navigationBarTitle("Let's async! 🥳")
            .task {
//                await vm.getImages()
                await vm.getImagesWithTaskGroup()
            }
        }
    }
}

struct TaskGroupBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TaskGroupBootcamp()
    }
}
