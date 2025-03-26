// TuApp.swift (reemplaza "TuApp" con el nombre de tu aplicación)
import SwiftUI

@main
struct Proyecto_HuertitaApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
