//
//  ConsultasView.swift
//  Proyecto_TuVoto
//
//  Created by user278708 on 10/7/25.
//

import SwiftUI

struct ConsultasView: View {
    // Esta variable de entorno es la llave para abrir enlaces fuera de la app
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                
                // LOCAL DE VOTACIÓN
                VStack(alignment: .center, spacing: 15) {
                    Text("¿Conoces tu local de votación?")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    Text("No te preocupes, puedes encontrar tu local de votación y la información que necesitas para ejercer tu derecho al voto haciendo clic en el siguiente botón.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    // Botón que navega a la ONPE
                    Button {
                        // URL Oficial de consulta (Suele ser esta o www.gob.pe/onpe)
                        if let url = URL(string: "https://consultaelectoral.onpe.gob.pe/") {
                            openURL(url)
                        } else if let fallbackUrl = URL(string: "https://www.gob.pe/onpe") {
                            // Si la primera falla o es inválida, usa la general
                            openURL(fallbackUrl)
                        }
                    } label: {
                        Image("votacion")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .padding()
                            .background(Color(red: 30/255, green: 55/255, blue: 119/255))
                            .cornerRadius(16)
                            .shadow(radius: 4)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.horizontal)
                
                
                // MIEMBRO DE MESA
                VStack(alignment: .center, spacing: 15) {
                    Text("¿Eres miembro de mesa?")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    Text("Esta es una importante responsabilidad cívica. Averigua si eres uno de los ciudadanos que tendrán la importante misión haciendo clic en el siguiente botón.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    Button {
                        // Enlace directo a la sección de miembros de mesa
                        if let url = URL(string: "https://www.gob.pe/institucion/onpe/tema/miembros-de-mesa") {
                            openURL(url)
                        }
                    } label: {
                        Image("miembro_mesa")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .padding()
                            .background(Color(red: 30/255, green: 55/255, blue: 119/255))
                            .cornerRadius(16)
                            .shadow(radius: 4)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.horizontal)
            }
            .padding(.top, 40)
        }
        .background(Color(uiColor: .systemGray6))
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("Consultas")
    }
}

#Preview {
    NavigationView {
        ConsultasView()
    }
}
