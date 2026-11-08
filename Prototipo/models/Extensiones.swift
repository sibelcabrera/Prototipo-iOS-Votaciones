//
//  Extensiones.swift
//  Prototipo
//
//  Created by user278672 on 10/6/25.
//

import Foundation
import SwiftUI

extension View {
    func usuriodField() -> some View {
        self
            .keyboardType(.default)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .padding(.vertical, 0)
            .padding(.horizontal, 1)
            .font(.headline)
            .background(Color.gray.opacity(0.4))
            .overlay {
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.white, lineWidth: 3)
            }
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .padding(.horizontal, 20)
    }
    
    func passwordField() -> some View {
        self
            .keyboardType(.default)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .padding(.vertical, 0)
            .padding(.horizontal, 1)
            .font(.headline)
            .background(Color.gray.opacity(0.4))
            .overlay {
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.white, lineWidth: 3)
            }
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .padding(.horizontal, 20)
    }
}

extension Text {
    func textIngresa() -> some View {
        self
            .padding(.vertical, 14)
            .padding(.horizontal, 145)
            .background(Color("Color1"))
            .font(.system(size: 22))
            .foregroundStyle(.white)
            .cornerRadius(50)
            .shadow(radius: 10)
    }
    func textRegistrate() -> some View {
        self
            .padding(.vertical, 12)
            .padding(.horizontal, 110)
            .background(Color("Color1"))
            .font(.system(size: 21))
            .foregroundStyle(.white)
            .cornerRadius(50)
            .shadow(radius: 10)
    }
    func botonTodos() -> some View {
        self
            .foregroundStyle(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .background(Color.gray)
            .cornerRadius(50)
    }
    func botonRegistrate() -> some View {
        self
            .foregroundStyle(.white)
            .padding(.vertical, 15)
            .padding(.horizontal, 125)
            .font(.headline)
            .background(Color.gray.opacity(0.2))
            .overlay {
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.white, lineWidth: 3)
            }
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .padding(.horizontal, 20)
    }
    func botonCategoria() -> some View {
        self
            .foregroundStyle(Color.black)
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(Color.white)
            .overlay {
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color("Color"), lineWidth: 3)
            }
            .cornerRadius(50)
            .shadow(radius: 1)
    }
}

extension Image {
    func imagenusuario() -> some View {
        self
            .foregroundColor(.white)
            .font(.system(size: 25))
            .padding(10)
            .background(
                Circle()
                    .stroke(Color.white, lineWidth: 2)
            )
    }
    func imagencontraseña() -> some View {
        self
            .foregroundColor(.white)
            .font(.system(size: 25))
            .padding(10)
            .background(
                Circle()
                    .stroke(Color.white, lineWidth: 2)
            )
    }
    func imagengoogle() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: 35)
    }
    func imagenFacebook() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: 35)
    }
}

extension HStack {
    func botongoogle() -> some View {
        self
            .padding()
            .background(.gray.opacity(0.3))
            .overlay {
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.white, lineWidth: 2)
            }
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .font(.system(size: 22))
            .foregroundStyle(.white)
    }
    func botonFacebook() -> some View {
        self
            .padding()
            .background(.gray.opacity(0.3))
            .overlay {
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.white, lineWidth: 2)
            }
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .font(.system(size: 22))
            .foregroundStyle(.white)
    }
    func passwordGoogle() -> some View {
        self
            .keyboardType(.numberPad)
            .disableAutocorrection(true)
            .padding(.vertical, 10)
            .padding(.horizontal, 1)
            .font(.headline)
            .background(Color.black.opacity(0.4))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 3)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 20)
    }
    func gmailGoogle() -> some View {
        self
            .keyboardType(.numberPad)
            .disableAutocorrection(true)
            .padding(.vertical, 10)
            .padding(.horizontal, 1)
            .font(.headline)
            .background(Color.black.opacity(0.4))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 3)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 20)
    }
}

extension ProcessInfo {
    var isPreview: Bool {
        environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}

enum Sheet: String, Identifiable {
    case registroFirebase
    case loginFirebase
    case loginFacebook
    
    var id: String { rawValue }
}

