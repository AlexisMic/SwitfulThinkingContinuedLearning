//
//  BackgroundThreadBootcamp.swift
//  SwitfulThinkingContinuedLearning
//
//  Created by Alexis Schotte on 10/23/21.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func loadArray() {
//        var data:[String] = []
        DispatchQueue.global(qos: .background).async {
            let data = self.downloadArray()
            
            print("CHECK 1: \(Thread.isMainThread)")
            print("CHECK 2: \(Thread.current)")
            
            DispatchQueue.main.async {
                self.dataArray = data
                
                print("CHECK 1: \(Thread.isMainThread)")
                print("CHECK 2: \(Thread.current)")
            }
        }
        
    }
    
    private func downloadArray() -> [String] {
        var data:[String] = []
        for i in 0 ..< 100 {
            data.append("\(i)")
            print(data)
        }
        return data
    }
    
}

struct BackgroundThreadBootcamp: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.loadArray()
                    }
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct BackgroundThreadBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadBootcamp()
    }
}
