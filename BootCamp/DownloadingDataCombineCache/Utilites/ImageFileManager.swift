//
//  ImageFileManager.swift
//  BootCamp
//
//  Created by MM on 22.11.2022.
//

import SwiftUI

class ImageFileManager {
    
    static var share = ImageFileManager()
    let folder = "downloaded_images"
    
    private init() {
        createFolderIfNeeded()
    }
    
    
    private func createFolderIfNeeded() {
        guard
            let url = getFolderPath()
        else {
            print("Bad FileManager URL")
            return
        }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(atPath: url.path, withIntermediateDirectories: true)
            }
            catch let error {
                print("Error creating a folder. \(error.localizedDescription)")
            }
        }
    }
    
    private func add(key: String, value: UIImage) {
        guard
            let url = getImagePath(key: key),
            let data = value.pngData()
        else {
            print("Bad FileManager image url")
            return
        }
        do {
            try data.write(to: url)
        }
        catch let error {
            print("Can't write data to url. \(error.localizedDescription)")
        }
//        FileManager
//            .default
//            .createFile(atPath: url.path, contents: value.pngData())
    }
    
    private func get(key: String) -> UIImage? {
        guard
            let url = getImagePath(key: key),
            FileManager.default.fileExists(atPath: url.path)
         else {
            print("Can't get image url" )
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    
    
    private func getFolderPath() -> URL? {
        FileManager
            .default // Contact to FileManager
            .urls(for: .cachesDirectory, in: .userDomainMask) // Get URL for cachesDir
            .first?
            .appendingPathComponent(folder)
    }
    
    private func getImagePath(key: String) ->URL? {
        FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folder + key + ".png")
    }
}
