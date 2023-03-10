//
//  UnitTestingBootcampViewModel.swift
//  BootCamp
//
//  Created by MM on 09.01.2023.
//

import SwiftUI

class UnitTestingBootcampViewModel: ObservableObject {
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    
    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
    
    func addItem(item: String) {
        guard !item.isEmpty else { return }
        self.dataArray.append(item)
    }
    
    // 
    func selectItem(name: String) {
        if let x = dataArray.first(where: { $0 == name } ) {
            selectedItem = x
        } else {
            selectedItem = nil
        }
    }
    
    func saveItem(item: String) throws {
        guard !item.isEmpty else {
            throw DataError.noData
        }
        
        if let x = dataArray.first(where: { $0 == item }) {
             print("Array already include String: \(x)")
        } else {
            throw DataError.itemNoFound
        }
    }
    
    enum DataError: LocalizedError {
        case noData
        case itemNoFound
    }
}
