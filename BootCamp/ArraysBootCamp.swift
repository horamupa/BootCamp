//
//  ArraysBootCamp.swift
//  BootCamp
//
//  Created by MM on 07.11.2022.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String
    let score: Int
    let isVerifide: Bool
}

class ArrayViewModel: ObservableObject {
    
    @Published var userArray: [UserModel] = []
    @Published var filtredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUser()
        updateFiltredArray()
    }
    
    func getUser() {
        let user1 = UserModel(name: "Mike", score: 5, isVerifide: true)
        let user2 = UserModel(name: "Mika", score: 35, isVerifide: false)
        let user3 = UserModel(name: "Mue", score: 54, isVerifide: true)
        let user4 = UserModel(name: "Lora", score: 55, isVerifide: false)
        let user5 = UserModel(name: "Grirog", score: 65, isVerifide: true)
        let user6 = UserModel(name: "Sasha", score: 65, isVerifide: true)
        let user7 = UserModel(name: "Kostya", score: 57, isVerifide: false)
        let user8 = UserModel(name: "Kolya", score: 15, isVerifide: true)
        let user9 = UserModel(name: "Mikola", score: 59, isVerifide: false)
        let user10 = UserModel(name: "Ararat", score: 50, isVerifide: true)
        
        self.userArray.append(contentsOf: [
        user1,
        user2,
        user3,
        user4,
        user5,
        user6,
        user7,
        user8,
        user9,
        user10
        ])
    }
    
    func updateFiltredArray() {
        //sort
        /*
        let newArray = userArray.sorted { user1, user2 in
            user1.score < user2.score
        }
        filtredArray = newArray
        // Shorter one, but the same
        filtredArray = userArray.sorted(by: { $0.score < $1.score })
        */
        //filtred
        /*
        filtredArray = userArray.filter({ user in
//            user.score > 50
//            !user.isVerifide
            user.name.contains("i")
        })
        //same but shorter
        filtredArray = userArray.filter({ $0.isVerifide })
         */
        //map
        /*
        // тут мы не просто сортируем, а меняем тип даты, которая содержится
        // была Array юсермоделов, стала аррей стрингов
        mappedArray = userArray.map({ user -> String in
            user.name
        })
        mappedArray = userArray.map({ $0.name })
         */
//        mappedArray = userArray.compactMap({$0.name})
        mappedArray = userArray
            .sorted(by: { $0.score > $1.score })
            .filter({ $0.isVerifide })
            .compactMap({$0.name})
    }
    
}


struct ArraysBootCamp: View {
    
    @StateObject var vm = ArrayViewModel()
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(vm.mappedArray, id: \.self) { user in
                    Text(user)
                        .font(.title2)
                }
                ForEach(vm.filtredArray) { user in
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        HStack {
                            Text("Points: \(user.score)")
                            Spacer()
                            if user.isVerifide {
                                Image(systemName: "flame.fill")
                            }
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background {
                        Color.blue.cornerRadius(10)
                    }
                    .padding(.horizontal, 10)
                }
            }
        }
    }
}

struct ArraysBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        ArraysBootCamp()
    }
}
