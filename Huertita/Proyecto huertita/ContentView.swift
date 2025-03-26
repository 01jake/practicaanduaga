// ContentView.swift
import SwiftUI

struct ContentView: View {
    @StateObject private var datos = DatosTareas()
    
    var body: some View {
        NListaTareas()
            .environmentObject(datos)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
