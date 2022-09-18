//
//  CoreDataRelationshipBootcamp.swift
//  SwitfulThinkingContinuedLearning
//
//  Created by Alexis Schotte on 6/6/22.
//

import SwiftUI
import CoreData

class CoreDataManeger {
    
    static let instance = CoreDataManeger()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error in loading Core Data: \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print("Error saving Core Data: \(error.localizedDescription)")
        }
    }
    
}

class CoreDataRelantinshipViewModel: ObservableObject {
    
    let manager = CoreDataManeger.instance
    
}

struct CoreDataRelationshipBootcamp: View {
    
    @StateObject var vm = CoreDataRelantinshipViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CoreDataRelationshipBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipBootcamp()
    }
}
