//
//  CoreDataBootcamp.swift
//  SwitfulThinkingContinuedLearning
//
//  Created by Alexis Schotte on 10/20/21.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = []
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Unsuccessfully load Core Data!!! \(error)")
            } else {
                print("Successfully load Core Data!!!")
            }
        }
        fechtData()
    }
    
    func fechtData() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error on fetch request: \(error)")
        }
        
    }
    
    func addFruit(name: String) {
        let newEntity = FruitEntity(context: container.viewContext)
        newEntity.name = name
        saveEntity()
    }
    
    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveEntity()
    }
    
    func updateFruit(fruit: FruitEntity) {
        let updatedFruit = fruit
        updatedFruit.name! += "!"
        saveEntity()
    }
    
    func saveEntity() {
        do {
            try container.viewContext.save()
            fechtData()
        } catch let error {
            print("Error on saving: \(error)")
        }
    }
}

struct CoreDataBootcamp: View {
    
    @StateObject var vm = CoreDataViewModel()
    @State private var textTextField = ""
    let oneColor: UIColor =  #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)

    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Add a new fruit", text: $textTextField)
                    .font(.headline)
                    .frame(height: 55)
                    .padding(.leading)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)).cornerRadius(10))
                    .padding(.horizontal)
                Button {
                    guard !textTextField.isEmpty else { return  }
                        vm.addFruit(name: textTextField)
                        textTextField = ""
                    
                    
                } label: {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color(#colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)).cornerRadius(10))
                        .padding(.horizontal)
                }
                List {
                    ForEach(vm.savedEntities) { fruit in
                        Text(fruit.name ?? "No name")
                            .onTapGesture {
                                vm.updateFruit(fruit: fruit)
                            }
//
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Fruits")
        }
    }
}

struct CoreDataBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootcamp()
    }
}
