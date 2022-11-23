//
//  ImageCacheManager.swift
//  BootCamp
//
//  Created by MM on 22.11.2022.
//

import SwiftUI

class ImageCacheManager {
    
    static var share = ImageCacheManager()
    
    private init() { }
    
    var cache: NSCache<NSString, UIImage> {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100 // limit 100 entity to cache
        cache.totalCostLimit = 1024*1024*100 // limit 100mb
        return cache
    }
    
    func addCache(key: String, image: UIImage) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func getCache(key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
}
