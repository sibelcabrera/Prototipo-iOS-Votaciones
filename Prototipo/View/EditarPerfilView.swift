import SwiftUI

struct EditarPerfilView: View {
    @State private var newName: String = "María Luana López Fernández"
    @State private var newPhone: String = "555 123 4567"
    @State private var birthDate: Date = Calendar.current.date(byAdding: .year, value: -25, to: Date()) ?? Date()
    @State private var profileImageName: String = "perfil_mujer"
    
    @State private var showingImagePicker = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        // Usamos este VStack para apilar el Form y el Botón
        VStack(spacing: 0) {
            
            // FORMULARIO: Ocupa el espacio disponible para el contenido
            Form {
                
                Section {
                    VStack(alignment: .center) {
                        // Imagen de Perfil
                        Image(profileImageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                            .padding(.bottom, 10)
                        
                        // Botón para cambiar la imagen
                        Button("Cambiar Imagen de Perfil") {
                            self.showingImagePicker = true
                        }
                        .font(.callout)
                    }
                    .frame(maxWidth: .infinity)
                }
                
                // INFORMACIÓN BÁSICA
                Section(header: Text("INFORMACIÓN BÁSICA")) {
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Nombre:").font(.caption).foregroundColor(.secondary)
                        TextField("Ingresa tu nombre completo", text: $newName)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray6))
                            .cornerRadius(5)
                            .padding(.horizontal, -8)
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Fecha de Nacimiento:").font(.caption).foregroundColor(.secondary)
                        DatePicker("", selection: $birthDate, displayedComponents: .date)
                            .labelsHidden()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray6))
                            .cornerRadius(5)
                            .padding(.horizontal, -8)
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Correo Electrónico:").font(.caption).foregroundColor(.secondary)
                        Text("marialuana.lopezf@gmail.com")
                            .foregroundColor(.primary)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray6))
                            .cornerRadius(5)
                            .padding(.horizontal, -8)
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Teléfono:").font(.caption).foregroundColor(.secondary)
                        TextField("Ingresa tu teléfono", text: $newPhone)
                            .keyboardType(.phonePad)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray6))
                            .cornerRadius(5)
                            .padding(.horizontal, -8)
                    }
                }
                .textCase(nil)
            }
            
            
            Button(action: {
                saveChanges()
                dismiss()
            }) {
                Text("GUARDAR")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: 150)
                    .padding(.vertical, 15)
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            .padding(.bottom, 50)
        }
        .navigationTitle("Editar Perfil")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Función de Guardado
    func saveChanges() {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        
        print("Guardando cambios:")
        print("Nombre: \(newName)")
        print("Fecha Nac.: \(formatter.string(from: birthDate))")
        print("Teléfono: \(newPhone)")
    }
}

// ----------------------------------------------------

#Preview {
    NavigationView {
        EditarPerfilView()
    }
}
