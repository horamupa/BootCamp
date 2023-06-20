//
//  CheckedContinuationBootcamp.swift
//  BootCamp
//
//  Created by MM on 04.06.2023.
//


// for libraries without async/await

import SwiftUI

class CheckedContinuationDataManager {
    
    func getData(url: String) async throws -> UIImage {
        guard let url = URL(string: url) else { throw URLError(.badURL) }
        let (data,_) = try await URLSession.shared.data(from: url)
        if let image = UIImage(data: data) {
            return image
        } else { throw URLError(.badURL) }
    }
    
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

class CheckedContinuationViewModel: ObservableObject {
    
    @Published var image: UIImage?
    
    //better be injected
    var dataManager = CheckedContinuationDataManager()
    
    func getData() async {
        image = try? await dataManager.fetchImage(urlString: "https://picsum.photos/300")
    }
    
    func getData2() async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: URL(string: "https://picsum.photos/300")!) { data, response, error in
                if let data = data {
                    continuation.resume(returning: data)
                } else if let error = error { continuation.resume(throwing: error)} else { continuation.resume(throwing: URLError(.badURL))}
            }
            .resume()
        }
    }
    
    func getHeartImageFromDatabase(completionHandler: @escaping (_ image: UIImage) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            completionHandler(UIImage(systemName: "heart")!)
        }
    }
    
    func getData3() async  -> UIImage {
        await withCheckedContinuation { continuation in
            getHeartImageFromDatabase { image in
                    return continuation.resume(returning: image)
            }
            
        }
    }
    
//    func getImages() async {
//        if let images = try? await dataManager.fetchWithAsyncLet() {
//            self.images.append(contentsOf: images)
//        }
//    }
//
//    func getImagesWithTaskGroup() async {
//        if let images = try? await dataManager.fetchImagesWithTaskGroup() {
//            self.images.append(contentsOf: images)
//        }
//    }
}
 
struct CheckedContinuationBootcamp: View {
    
    @StateObject var vm = CheckedContinuationViewModel()
    
    let columns = [GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    if let image = vm.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                    
                }
            }
            .navigationBarTitle("Let's async! 🥳")
            .task {
//                await vm.getData()
                if let image = try? await vm.getData3() {
                        vm.image = image
                    }
            }
        }
    }
}

struct CheckedContinuationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CheckedContinuationBootcamp()
    }
}
