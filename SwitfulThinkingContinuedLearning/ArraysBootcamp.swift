//
//  ArraysBootcamp.swift
//  SwitfulThinkingContinuedLearning
//
//  Created by Alexis Schotte on 10/19/21.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var sortedArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray:[String] = []
    @Published var sortFilterMapArray:[String] = []
    
    init() {
        getUsers()
        sortedUsers()
        filteredUsers()
        mappedUsers()
        sortFilterMapUsers()
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Alexis", points: 100, isVerified: true)
        let user2 = UserModel(name: "Mina", points: 110, isVerified: true)
        let user3 = UserModel(name: "Clarinha", points: 50, isVerified: true)
        let user4 = UserModel(name: "Henrique", points: 50, isVerified: true)
        let user5 = UserModel(name: "Pierre", points: 0, isVerified: false)
        let user6 = UserModel(name: "Bella", points: 10, isVerified: true)
        let user7 = UserModel(name: nil, points: 20, isVerified: true)
        let user8 = UserModel(name: "Herminia", points: 30, isVerified: false)
        let user9 = UserModel(name: "Liliana", points: 60, isVerified: true)
        let user10 = UserModel(name: "Jean", points: 40, isVerified: true)
//        users = [UserModel]()
        dataArray.append(contentsOf: [
        user1,
        user2,
        user3,
        user4,
        user5,
        user6,
        user7,
        user8,
        user9,
        user10,
        ])
    }
    
    func sortedUsers() {
        // Sorted by points
//        sortedArray = dataArray.sorted(by: {$0.points > $1.points})
        
        // Sorted by name
//        sortedArray = dataArray.sorted(by: {$0.name < $1.name})
        
    }
    
    func filteredUsers() {
        // Filtered by points >= 50
        filteredArray = dataArray.filter({$0.points >= 50})
        
        // Filtered by !isVerified
//        filteredArray = dataArray.filter({!$0.isVerified})
    }
    
    func mappedUsers() {
        // Mapped by name
//        mappedArray = dataArray.map({$0.name})
        
        // Mapped by points
//        mappedArray = dataArray.map({String($0.points)})
        
        // Mapped by name but doesn't include nil (for optionals)
        mappedArray = dataArray.compactMap({$0.name})
    }
    
    func sortFilterMapUsers() {
        // Sort by points then filter by isVerified and map by name
        sortFilterMapArray = dataArray
            .sorted(by: {$0.points > $1.points})
            .filter({$0.isVerified})
            .compactMap({$0.name})
    }
}

struct ArraysBootcamp: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(vm.sortFilterMapArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
//                ForEach(vm.filteredArray) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        HStack {
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                                    .foregroundColor(Color.orange)
//                            }
//                        }
//                    }
//                    .foregroundColor(Color.white)
//                    .padding()
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal)
//
//                }
            }
            
        }
    }
}

struct ArraysBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ArraysBootcamp()
    }
}
