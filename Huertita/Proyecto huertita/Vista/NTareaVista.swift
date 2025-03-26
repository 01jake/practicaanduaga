// Vistas/NTareaVista.swift
import SwiftUI

struct NTareaVista: View {
    @Binding var tarea: NTarea
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var datos: DatosTareas
    @State var completa: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Detalles de la tarea")) {
                TextField("Título", text: $tarea.titulo)
                
                Toggle("Completada", isOn: $tarea.isCompletada)
                
                Picker("Prioridad", selection: $tarea.prioridad) {
                    ForEach(NTarea.Prioridad.allCases, id: \.self) { prioridad in
                        Text(prioridad.rawValue).tag(prioridad)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Section {
                DatePicker(
                    "Fecha de vencimiento",
                    selection: Binding(
                        get: { tarea.fechaVencimiento ?? Date() },
                        set: { tarea.fechaVencimiento = $0 }
                    ),
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
            }
        }
        .navigationTitle("Editar Tarea")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Guardar") {
                    datos.guardarTareas()
                    dismiss()
                }
            }
        }
        .onAppear {
            completa = tarea.isCompletada
        }
    }
}

struct NTareaVista_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NTareaVista(tarea: .constant(NTarea(titulo: "Ejemplo", isCompletada: false, prioridad: .media)))
                .environmentObject(DatosTareas())
        }
    }
}
