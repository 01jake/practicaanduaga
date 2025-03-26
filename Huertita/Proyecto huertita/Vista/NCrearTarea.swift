// Vistas/NCrearTareaView.swift
import SwiftUI
import CoreData

struct NCrearTareaView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State private var titulo = ""
    @State private var descripcion = ""
    @State private var completa = false
    @State private var prioridad = "Media"
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Información de la tarea")) {
                    TextField("Título", text: $titulo)
                    TextField("Descripción", text: $descripcion)
                    
                    Picker("Prioridad", selection: $prioridad) {
                        ForEach(["Baja", "Media", "Alta"], id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Toggle("Completada", isOn: $completa)
                }
            }
            .navigationTitle("Nueva Tarea")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        agregarTarea()
                        dismiss()
                    }
                    .disabled(titulo.isEmpty)
                }
            }
        }
    }
    
    private func agregarTarea() {
        withAnimation {
            let nuevaTarea = Tarea(context: viewContext)
            nuevaTarea.titulo = titulo
            nuevaTarea.descripcion = descripcion
            nuevaTarea.completa = completa
            nuevaTarea.prioridad = prioridad
            nuevaTarea.fechaCreacion = Date()
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Error no resuelto \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct NCrearTareaView_Previews: PreviewProvider {
    static var previews: some View {
        NCrearTareaView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
