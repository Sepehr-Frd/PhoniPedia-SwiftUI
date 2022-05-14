//
//  DataController.swift
//  PhoniPedia (SwiftUI)
//
//  Created by Sepehr Foroughi Rad on 5/7/22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "PhoniPedia (SwiftUI)")
    
    init() {
        
        container.loadPersistentStores { description, error in
            
            if let error = error {
                print("CoreData failed to load: \(error.localizedDescription)")
                
            }
            
            
        }
        
    }
}
