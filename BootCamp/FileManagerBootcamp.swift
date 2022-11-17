//
//  FileManagerBootcamp.swift
//  BootCamp
//
//  Created by MM on 17.11.2022.
//

import SwiftUI

struct LocalFileManager {
    
    static let instance = LocalFileManager()
    
    func saveImage(image: UIImage, name: String) {
        
        guard
            let data = image.pngData(),
            let path = getPath(name: name)
        else {
            print("Image to data converting error")
            return
        }
        
        do {
            try data.write(to: path)
            print("Data saved successfully")
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func getImage(name: String) -> UIImage? {
        guard
            let path = getPath(name: name)?.path(),
            FileManager.default.fileExists(atPath: path)
        else {
            print("Path to file don't exist")
            return nil
        }
        print(path)
        return UIImage(contentsOfFile: path)
    }
    
    func getPath(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent("\(name).png")
        else {
            print("Can't create a path to file")
            return nil
        }
        return path
    }
}

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let FM = LocalFileManager.instance
    let imageName: String = "download"
    
    init() {
        getImageFromAssetsFolder()
//        getImageFromFileManager()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager() {
        image = FM.getImage(name: imageName)
    }
    
    func saveImage() {
        guard
            let image = image
        else {
            print("Image saving probmel")
            return
        }
        FM.saveImage(image: image, name: imageName)
    }
}

struct FileManagerBootcamp: View {
    
    @State var isImageLoad: Bool = false
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                Button {
                    vm.saveImage()
                } label: {
                    Text("Save Image")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(.blue)
                        .cornerRadius(10)
                }
                Button {
                    vm.getImageFromFileManager()
                    isImageLoad.toggle()
                } label: {
                    Text("Load Image")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(.blue)
                        .cornerRadius(10)
                }
                if isImageLoad, let image = vm.image {
                        Image(uiImage: image)
                }
                Spacer()
            }
            .navigationTitle("FileManager")
        }
    }
}

struct FileManagerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerBootcamp()
    }
}
