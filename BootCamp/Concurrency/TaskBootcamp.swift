//
//  TaskBootcamp.swift
//  BootCamp
//
//  Created by MM on 17.04.2023.
//

import SwiftUI

class TaskBootcampViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    let url = URL(string: "https://i.pinimg.com/736x/a9/7f/b6/a97fb6f0c0a63d791eeda84eed71054f--cotton-candy-party-pink-cotton-candy.jpg")!
    func fetchImage() async {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            await MainActor.run {
                print("Image ready")
                self.image = UIImage(data: data)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage2() async {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            await MainActor.run {
                print("Image ready")
                self.image2 = UIImage(data: data)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}


struct TaskClickMe: View {
    var body: some View {
        NavigationView {
            NavigationLink("CLICK ME 🤓") {
                TaskBootcamp()
            }
        }
        
    }
}


struct TaskBootcamp: View {
    @StateObject var vm = TaskBootcampViewModel()
    @State var task: Task<(), Never>? = nil

    var body: some View {
        VStack(spacing: 40) {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            if let image = vm.image2 {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            await vm.fetchImage()
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            await vm.fetchImage2()
        }
//        .onDisappear {
//            self.task?.cancel()
//        }
//        .onAppear {
//            self.task = Task {
//                await vm.fetchImage()
//                try? await Task.sleep(nanoseconds: 3_000_000_000)
//                await vm.fetchImage2()
//            }
//        }
    }
}

struct TaskBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TaskClickMe()
    }
}
