// Modelos/NTarea.swift
import Foundation

struct NTarea: Identifiable, Codable {
    var id = UUID()
    var titulo: String
    var isCompletada: Bool
    var fechaVencimiento: Date?
    var prioridad: Prioridad
    
    enum Prioridad: String, CaseIterable, Codable {
        case baja = "Baja"
        case media = "Media"
        case alta = "Alta"
    }
}

class DatosTareas: ObservableObject {
    @Published var tareas: [NTarea] = []
    private let key = "tareasGuardadas"
    
    init() {
        cargarTareas()
    }
    
    func guardarTareas() {
        if let encoded = try? JSONEncoder().encode(tareas) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func cargarTareas() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([NTarea].self, from: data) {
            tareas = decoded
        }
    }
}
