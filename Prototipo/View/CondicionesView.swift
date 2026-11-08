import SwiftUI

struct CondicionesView: View {
    // Texto largo de ejemplo para las condiciones de servicio
    let termsText: String = """
    1. Aceptación de las Condiciones
    Al acceder y utilizar el servicio de "Tu Voto", usted acepta estar legalmente vinculado por estas Condiciones de Servicio. Si no está de acuerdo con todas las condiciones, le pedimos que no utilice nuestros servicios.

    2. Uso del Servicio
    Usted se compromete a utilizar la plataforma solo con fines legales y de manera que no infrinja los derechos ni restrinja o inhiba el uso y disfrute de la plataforma por parte de terceros.

    3. Registro y Cuentas
    Para acceder a ciertas funciones, es posible que deba crear una cuenta. Usted es responsable de mantener la confidencialidad de su contraseña y de todas las actividades que ocurran bajo su cuenta.

    4. Derechos de Propiedad Intelectual
    Todo el contenido, gráficos, código y diseño de la aplicación son propiedad de [Nombre de la App/Empresa] y están protegidos por leyes de derechos de autor y propiedad intelectual.

    5. Terminación del Servicio
    Nos reservamos el derecho de suspender o terminar su acceso al servicio, sin previo aviso, por cualquier incumplimiento de estas Condiciones.

    6. Limitación de Responsabilidad
    [Nombre de la App] no será responsable por ningún daño directo, indirecto, incidental o consecuente que resulte del uso o la imposibilidad de usar el servicio.

    7. Cambios a las Condiciones
    Nos reservamos el derecho de modificar o reemplazar estas condiciones en cualquier momento. El uso continuado del servicio después de dichos cambios constituye su aceptación de las nuevas condiciones.
    """
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Última actualización: 30 de Octubre de 2025")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                // Texto principal de las condiciones
                Text(termsText)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
        // Aplica el título de navegación
        .navigationTitle("Condiciones de Servicio")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        CondicionesView()
    }
}
