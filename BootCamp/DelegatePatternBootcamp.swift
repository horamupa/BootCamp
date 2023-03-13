//
//  DelegatePatternBootcamp.swift
//  BootCamp
//
//  Created by MM on 11.03.2023.
//

import SwiftUI

struct DelegatePatternBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DelegatePatternBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DelegatePatternBootcamp()
    }
}

//карточка товара просит пересчитать корзину, послу добавления нового товара.

struct Product {
    let name: String
    let price: String
}

protocol AddProductDelegate {
    func addNew(_:Product)
}

class ProductScreen {
    let product: Product
    var delegate: AddProductDelegate?
    
    init(product: Product) {
        self.product = product
    }
    
    /// эта функция обращается к делегату у дёргает у него addNew
    func addToCard() {
        delegate?.addNew(product)
    }
}

class ShopCart: AddProductDelegate {
    var products: [Product] = []
    func addNew(_ product: Product) {
        self.products.append(product)
    }
}



