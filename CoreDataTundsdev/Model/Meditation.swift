//
//  Meditation.swift
//  BootCamp
//
//  Created by MM on 19.06.2023.
//

import Foundation
import CoreData

final class Meditation: NSManagedObject {
    
    @NSManaged var dob: Date
    @NSManaged var number: Int
    @NSManaged var isLiked: Bool
    @NSManaged var isLissent: Bool
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        setPrimitiveValue(Date.now, forKey: "dob")
        setPrimitiveValue(false, forKey: "isLiked")
        setPrimitiveValue(false, forKey: "isLissent")
    }
}
