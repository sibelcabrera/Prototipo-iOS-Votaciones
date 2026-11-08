import SwiftUI

struct NosotrosView: View {
    var body: some View {
        // Usamos ScrollView para asegurar que el contenido sea accesible en pantallas pequeñas
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Título principal
                Text("Nuestra Misión y Visión")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                
                // Imagen o Icono representativo
                Image(systemName: "building.2.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding(.bottom, 10)
                
                // Texto de Misión
                VStack(alignment: .leading, spacing: 8) {
                    Text("Misión")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("En Tu Voto, estamos comprometidos con la transparencia y la participación ciudadana. Nuestra misión es proporcionar una plataforma accesible y segura que empodere a los votantes con información verificada y herramientas para la toma de decisiones informada.")
                        .font(.body)
                        .foregroundColor(.primary)
                }
                
                Divider()
                
                // Texto de Visión
                VStack(alignment: .leading, spacing: 8) {
                    Text("Visión")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("Ser el líder tecnológico en soluciones cívicas, redefiniendo la forma en que los ciudadanos interactúan con el proceso democrático. Buscamos una sociedad donde cada voto esté basado en el conocimiento completo y la confianza en el sistema.")
                        .font(.body)
                        .foregroundColor(.primary)
                }
                
                Divider()
                
                // Información de Contacto
                VStack(alignment: .leading, spacing: 8) {
                    Text("Contáctanos")
                        .font(.headline)
                    
                    Text("Correo: contacto@tuempresa.com")
                    Text("Teléfono: +51 987 654 321")
                }
                .padding(.top, 10)
                
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
        .navigationTitle("Sobre Nosotros")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        NosotrosView()
    }
}
