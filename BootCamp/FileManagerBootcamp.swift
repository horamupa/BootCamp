//
//  FileManagerBootcamp.swift
//  BootCamp
//
//  Created by MM on 17.11.2022.
//

import SwiftUI

struct LocalFileManager {
    
    let folderName = "SpaceXapp"
    static let instance = LocalFileManager()
    
    init() {
        createFolderIfNeeded()
    }
    
    /// Create folder in FileManager with name of parametr folderName
    func createFolderIfNeeded() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
        else {
            print("Can't create a path to file")
            return
        }
        
        if !FileManager.default.fileExists(atPath: path.path()) {
            do {
                try FileManager.default.createDirectory(at: path, withIntermediateDirectories: true)
            } catch let error {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func deleteFolder() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
        else {
            print("Can't create a path to file")
            return
        }
        
        do {
            try FileManager.default.removeItem(at: path)
            print("Success deleting folder.")
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    func saveImage(image: UIImage, name: String) -> String {
        
        guard
            let data = image.pngData(),
            let path = getPath(name: name)
        else {
            return "Image to data converting error"
            
        }
        
        do {
            try data.write(to: path)
            return "Data saved successfully"
        } catch let error {
            return error.localizedDescription
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
        
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(name: String) -> String {
        guard
            let path = getPath(name: name),
            FileManager.default.fileExists(atPath: path.path())
        else {
            return "Path to file don't exist"
        }
        do {
            try FileManager.default.removeItem(at: path)
            return "Successful delete"
        } catch let error {
            return "Deliting problem, error: \(error.localizedDescription)"
        }
    }
    
    func getPath(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
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
    @Published var savingFeedback: String = ""
    let FM = LocalFileManager.instance
    let imageName: String = "download"
    
    init() {
        getImageFromAssetsFolder()
//        getImageFromFileManager()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    ///
    func getImageFromFileManager() {
        image = FM.getImage(name: imageName)
    }
    
    #warning("refactor this later")
    func saveImage() {
        guard
            let image = image
        else {
            print("Image saving problem")
            return
        }
        savingFeedback = FM.saveImage(image: image, name: imageName)
    }
    
    func deleteImage() {
        savingFeedback = FM.deleteImage(name: imageName)
        FM.deleteFolder()
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
                Button {
                    vm.deleteImage()
                } label: {
                    Text("Deleting image")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(.blue)
                        .cornerRadius(10)
                }
                Text(vm.savingFeedback)
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
