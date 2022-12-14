//
//  ImageModel.swift
//  BootCamp
//
//  Created by MM on 21.11.2022.
//

import SwiftUI

struct ImageModel: Identifiable, Codable {
    
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
}
