// Vistas/EditarTareaView.swift
import SwiftUI
import CoreData

struct EditarTareaView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var tarea: Tarea
    
    var body: some View {
        Form {
            Section(header: Text("Información de la tarea")) {
                TextField("Título", text: Binding($tarea.titulo, ""))
                TextField("Descripción", text: Binding($tarea.descripcion, ""))
                
                Picker("Prioridad", selection: Binding($tarea.prioridad, "Media")) {
                    ForEach(["Baja", "Media", "Alta"], id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                
                Toggle("Completada", isOn: $tarea.completa)
            }
        }
        .navigationTitle("Editar Tarea")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Guardar") {
                    guardarCambios()
                    dismiss()
                }
            }
        }
    }
    
    private func guardarCambios() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Error no resuelto \(nsError), \(nsError.userInfo)")
        }
    }
}

struct EditarTareaView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let nuevaTarea = Tarea(context: context)
        nuevaTarea.titulo = "Tarea de ejemplo"
        nuevaTarea.descripcion = "Descripción de ejemplo"
        nuevaTarea.completa = false
        nuevaTarea.prioridad = "Media"
        
        return EditarTareaView(tarea: nuevaTarea)
            .environment(\.managedObjectContext, context)
    }
}
