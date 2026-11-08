//
//  GoogleView.swift
//  Prototipo
//
//  Created by Sibel Rodriguez on 29/10/25.
//

import SwiftUI

struct GoogleView: View {
    @State var ingresa: Bool = false
    @State var crearCuenta: Bool = false
    @State var iniciarSesion: Bool = false
    @State private var isNotRobot = false
    @State var user: String = ""
    @State var password: String = ""
    var body: some View {
        ZStack(){
            LinearGradient(gradient: Gradient(colors: [Color("Color1"), Color("Color3"), Color("Color3"), Color("Color1")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30){
                Image("google2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                HStack(){
                    Image(systemName: "")
                        
                    TextField("", text: $user,
                             prompt:  Text("GMAIL")
                        .foregroundColor(.white)
                        .font(.system(size: 22))
                    )
                    .padding(.horizontal, 45)
                    
                }
                .gmailGoogle()
                HStack(){
                    Image(systemName: "")
                        
                    TextField("", text: $password,
                              prompt: Text("CONTRASEÑA")
                        .foregroundColor(.white)
                        .font(.system(size: 22))
                    )
                    .padding(.horizontal, 45)
                }
                .passwordGoogle()
                // Casilla ¿Eres un robot?
                           Toggle(isOn: $isNotRobot) {
                               Text("¿Eres un robot?")
                                   .foregroundColor(.white)
                                   .font(.system(size: 18, weight: .medium))
                               
                           }
                           .padding(.horizontal, 50)
                           .keyboardType(.numberPad)
                               .disableAutocorrection(true)
                               .padding(.vertical, 10)
                               .padding(.horizontal, 1)
                               .font(.headline)
                               .background(Color.black.opacity(0.4))
                               .overlay(content: {
                                   RoundedRectangle(cornerRadius: 10)
                                       .stroke(Color.white, lineWidth: 3)
                               })
                               .clipShape(RoundedRectangle(cornerRadius: 10))
                               .padding(.horizontal, 20)
                
                Button(action: {
                    ingresa.toggle()
                }, label: {
                    Text("INGRESA")
                        .textIngresa()
                }).fullScreenCover(isPresented: $ingresa, content: {
                    TabViewView()
                })
                Text("¿Olvidaste tu contraseña?")
                    .foregroundStyle(.white)
            }
            
        }
    }
}

#Preview {
    GoogleView()
}
