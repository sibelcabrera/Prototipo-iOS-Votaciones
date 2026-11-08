//
//  FirebaseModel.swift
//  PrimerProyecto
//
//  Created by user278672 on 11/29/25.
//aqui se crea la autenticacion

import Foundation
import FirebaseAuth

public class FirebaseModel{ //aqui se van a crear los metodos
    
    func getUser() -> UserModel? { //nos devuelve el usuario y ese usuario esta en UserModel. verifica si el usurio esta activo y si es asi te deja entrar sin poner tu correo y contrasena otra vez
        guard let email = Auth.auth().currentUser?.email
        else {
            return nil
        }
        return .init(email: email)
    }
    func createUser(email: String, password: String, completionBlock: @escaping(Result<UserModel, Error>) -> Void){ //crea usuario
        
        Auth.auth().createUser(withEmail: email, password: password){ AuthDataResult, error in
            if let error = error {
                print("Error al crear usuario \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let email = AuthDataResult?.user.email ?? ""
            print("Usuario creado correctamente")
            completionBlock(.success(.init(email: email)))
        }
    }
    func loginUser(email: String, password: String, completionBlock: @escaping(Result<UserModel, Error>) -> Void){ //crea usuario
        
        Auth.auth().signIn(withEmail: email, password: password){ AuthDataResult, error in
            if let error = error {
                print("Error al autenticar usuario \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let email = AuthDataResult?.user.email ?? ""
            print("Usuario autenticado correctamente")
            completionBlock(.success(.init(email: email)))
        }
    }
    func editUser(){
        
    }
    func deleteUser(){  //para borrar usuario
        
    }
    func logOutUser() throws { //cerrar sesion
        try Auth.auth().signOut()
    }
    
}


