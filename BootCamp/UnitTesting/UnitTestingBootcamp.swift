//
//  UnitTestingBootcamp.swift
//  BootCamp
//
//  Created by MM on 09.01.2023.
//

import SwiftUI



struct UnitTestingBootcamp: View {
    @StateObject var vm: UnitTestingBootcampViewModel
    
    init(isPremium: Bool) {
        _vm = StateObject(wrappedValue: UnitTestingBootcampViewModel(isPremium: isPremium))    }
     
    var body: some View {
        VStack {
            Text("Hello, World!")
            Text(vm.isPremium.description)
        }
        
    }
}

struct UnitTestingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        UnitTestingBootcamp(isPremium: true)
    }
}
