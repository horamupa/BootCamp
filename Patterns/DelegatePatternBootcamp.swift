//
//  DelegatePatternBootcamp.swift
//  BootCamp
//
//  Created by MM on 11.03.2023.
//

import SwiftUI

//карточка товара просит пересчитать корзину, послу добавления нового товара.

struct Product {
    let name: String
    let price: Double
}

struct Position {
    let product: Product
    let count: Double
    var cost: Double { product.price * count }
}

protocol ShopViewDelegate {
    func addNew(_:Product, count: Double)
}

// Inside delegator - func send, to delegate.
class ShopViewModel {
    var products = [Product]()
    var delegate: ShopViewDelegate?
    
    // Send to Delegate
    func addToCard(product: Product, count: Double) {
        delegate?.addNew(product, count: count)
    }
}

// I'm delegate, I will do whatever you want.
class Cart: ShopViewDelegate {
    var positions: [Position] = []
    
    func addNew(_ product: Product, count: Double) {
        self.positions.append(Position(product: product, count: count))
    }
    
    var cost: Double {
        var sum: Double = 0
        for position in positions {
            sum += position.cost
        }
        return sum
    }
}

class MainEngineDelegate {
    var catalog = ShopViewModel()
    let cart = Cart()
    let prod1 = Product(name: "Burger", price: 16)
    let prod2 = Product(name: "Beef", price: 66)
    let prod3 = Product(name: "Milk", price: 26)
    
    func go() {
        catalog.delegate = cart
        catalog.products.append(contentsOf: [prod3,prod2,prod1])
        catalog.addToCard(product: catalog.products.randomElement()!, count: 2)
    }
    
}


