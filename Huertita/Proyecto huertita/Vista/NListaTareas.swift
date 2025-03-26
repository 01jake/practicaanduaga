// Vistas/NListaTareasView.swift
import SwiftUI
import CoreData

struct NListaTareasView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Tarea.fechaCreacion, ascending: false)],
        animation: .default)
    private var tareas: FetchedResults<Tarea>
    
    @State private var mostrarCrearTarea = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(tareas) { tarea in
                    NavigationLink {
                        EditarTareaView(tarea: tarea)
                    } label: {
                        HStack {
                            Image(systemName: tarea.completa ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(tarea.completa ? .green : .gray)
                            VStack(alignment: .leading) {
                                Text(tarea.titulo ?? "Sin título")
                                    .font(.headline)
                                if let desc = tarea.descripcion, !desc.isEmpty {
                                    Text(desc)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: eliminarTareas)
            }
            .navigationTitle("Lista de Tareas")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        mostrarCrearTarea = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $mostrarCrearTarea) {
                NCrearTareaView()
            }
        }
    }
    
    private func eliminarTareas(offsets: IndexSet) {
        withAnimation {
            offsets.map { tareas[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Error no resuelto \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct NListaTareasView_Previews: PreviewProvider {
    static var previews: some View {
        NListaTareasView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
