
import SwiftUI

struct TerminosView: View {
    // Texto largo de ejemplo para los términos del acuerdo
    let agreementText: String = """
    1. Alcance y Objeto del Acuerdo
    Este Acuerdo de Términos rige el uso y acceso a todos los servicios, productos y contenido proporcionados por Tu Voto. Al registrarse o utilizar nuestros servicios, usted reconoce haber leído, entendido y aceptado los términos descritos aquí.

    2. Obligaciones del Usuario
    El usuario se compromete a:
    a) Proporcionar información precisa y actualizada durante el registro.
    b) No utilizar el servicio para fines ilegales o fraudulentos.
    c) Notificar inmediatamente cualquier uso no autorizado de su cuenta.

    3. Disposiciones de Privacidad
    Su uso del servicio también se rige por nuestra Política de Privacidad, la cual se incorpora a este Acuerdo por referencia. Al aceptar este documento, también acepta la recolección, uso y divulgación de su información conforme a dicha política.

    4. Limitaciones de Garantía
    La plataforma se proporciona "tal cual" y "según disponibilidad", sin garantías de ningún tipo, ya sean expresas o implícitas, incluyendo, pero no limitándose a, garantías de comerciabilidad, idoneidad para un propósito particular o no infracción.

    5. Ley Aplicable y Jurisdicción
    Este Acuerdo será interpretado y regido por las leyes del [País/Jurisdicción de tu empresa]. Cualquier disputa que surja de este Acuerdo estará sujeta a la jurisdicción exclusiva de los tribunales de [Ciudad/Área].

    6. Modificaciones
    Tu Voto se reserva el derecho de modificar o reemplazar cualquier parte de este Acuerdo. Es su responsabilidad revisarlo periódicamente para estar al tanto de los cambios. La continuación del uso de la plataforma después de la publicación de las modificaciones constituye la aceptación de dichas modificaciones.
    """
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Versión vigente a partir del 1 de Noviembre de 2025")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                // Texto principal de los términos
                Text(agreementText)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
        // Aplica el título de navegación
        .navigationTitle("Términos del Acuerdo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        TerminosView()
    }
}
