//
//  WeakSelfBootcamp.swift
//  SwitfulThinkingContinuedLearning
//
//  Created by Alexis Schotte on 10/23/21.
//

import SwiftUI

struct WeakSelfBootcamp: View {
    
    @AppStorage("count") var count: Int?
    
    var body: some View {
        NavigationView {
            NavigationLink("Navigate", destination: WeakSelfView())
                .navigationTitle("View 1")
                    .font(.largeTitle)
        }
        .overlay(
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green.cornerRadius(10))
            , alignment: .topTrailing
        )
        
    }
}

struct WeakSelfView: View {
    
    @StateObject var vm = WeakSelfViewViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("WeakSelfView")
                .font(.largeTitle)
                .foregroundColor(.red)
            
            if let data = vm.data {
                Text(data)
                    .font(.headline)
            }
        }
    }
}

class WeakSelfViewViewModel: ObservableObject {
    @Published var data:String? = nil
    
    init() {
        print("INIT")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
        print("DEINIT")
    }
    
    func getData() {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "NEW DATA!!!!"
        }
    }
}

struct WeakSelfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelfBootcamp()
    }
}
