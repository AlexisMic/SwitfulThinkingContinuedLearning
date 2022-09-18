//
//  CodableBootcamp.swift
//  SwitfulThinkingContinuedLearning
//
//  Created by Alexis Schotte on 10/24/21.
//

import SwiftUI

// Codable = Decodable + Encodable, e não precisa de toda a configuração!!!

struct CustomerModel: Identifiable, Codable { // Decodable, Encodable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
    
//    init(id: String, name: String, points: Int, isPremium: Bool) {
//        self.id = id
//        self.name = name
//        self.points = points
//        self.isPremium = isPremium
//    }
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case points
//        case isPremium // = "is_premium" se fosse necessario
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.points = try container.decode(Int.self, forKey: .points)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(name, forKey: .name)
//        try container.encode(points, forKey: .points)
//        try container.encode(isPremium, forKey: .isPremium)
//    }
}

class CodableViewModel: ObservableObject {
    @Published var customer: CustomerModel = CustomerModel(id: "1234", name: "Alexis", points: 10, isPremium: true)
    
    init() {
        getData()
    }
    // Transforma o JSON data e transforma em objeto usando o JSONDecoder
    func getData() {
        guard let data = getJSONData() else { return }
        
        do {
            customer = try JSONDecoder().decode(CustomerModel.self, from: data)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // Transforma o objeto em JSON usando o JSONEncoder
    func getJSONData() -> Data? {
        
        let customer = CustomerModel(id: "1", name: "eu", points: 100, isPremium: false)
        
        let jsonData = try? JSONEncoder().encode(customer)
        
//        let dicticionary: [String : Any] = [
//            "id": "1235",
//            "name": "Mina",
//            "points": 9,
//            "isPremium": true
//        ]
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: dicticionary, options: [])
        
        return jsonData
    }
}

struct CodableBootcamp: View {
    
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text(vm.customer.id)
            Text(vm.customer.name)
            Text("\(vm.customer.points)")
            Text(vm.customer.isPremium.description)
        }
    }
}

struct CodableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CodableBootcamp()
    }
}
