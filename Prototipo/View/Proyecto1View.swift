import SwiftUI

struct Proyecto1View: View {

    let candidato: Candidato
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    
                    if let url = URL(string: candidato.imagenCandidatoURL) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 260)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.color3, lineWidth: 5))
                        .shadow(radius: 20)
                        .padding(.top, 20)
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 260)
                            .foregroundColor(.gray)
                            .padding(.top, 20)
                    }
                    
                    Text(candidato.nombreCompleto.isEmpty ? "Nombre no disponible" : candidato.nombreCompleto)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Detalles Biográficos:")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.gray)

                        HStack {
                            Image(systemName: "briefcase.fill").foregroundColor(.blue)
                            Text("**Profesión:** \(candidato.profesion)")
                        }
                        
                        HStack {
                            Image(systemName: "location.fill").foregroundColor(.blue)
                            Text("**Nacimiento:** \(candidato.lugarNacimiento)")
                        }
                        
                        HStack {
                            Image(systemName: "calendar").foregroundColor(.blue)
                            Text("**Fecha:** \(formatoFecha(candidato.fechaNacimiento))")
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    Text("Propuesta política:")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Text(candidato.propuesta.resumen.isEmpty ? "No disponible" : candidato.propuesta.resumen)
                        .font(.body)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    
                    HStack(spacing: 15) {
                        
                        NavigationLink {
                            DetalleCandidatoView(candidato: candidato)
                        } label: {
                            Text("Ver más…")
                                .font(.system(size: 16, weight: .bold))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.color3)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .buttonStyle(FilledButtonStyle())
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 20)
            }
            .navigationTitle(candidato.nombreCompleto)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func formatoFecha(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: dateString) {
            formatter.dateStyle = .long
            formatter.locale = Locale(identifier: "es_ES")
            return formatter.string(from: date)
        }
        return dateString
    }
}

struct FilledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.color3)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
