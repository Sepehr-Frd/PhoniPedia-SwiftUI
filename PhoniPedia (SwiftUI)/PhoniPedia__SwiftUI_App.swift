//
//  PhoniPedia__SwiftUI_App.swift
//  PhoniPedia (SwiftUI)
//
//  Created by Sepehr Foroughi Rad on 5/2/22.
//
import CoreData
import SwiftUI

@main
struct PhoniPedia__SwiftUI_App: App {
    
    @StateObject private var dataController = DataController()
    
    var context: NSManagedObjectContext {
        dataController.container.viewContext
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, context)
                .onAppear {
                    SharedProperties.sharedMoc = context
                }
        }
    }
}
