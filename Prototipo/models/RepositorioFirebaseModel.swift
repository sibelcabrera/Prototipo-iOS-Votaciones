//
//  RepositorioFirebaseModel.swift
//  PrimerProyecto
//
//  Created by user278672 on 11/29/25.
//

import Foundation
public class RepositorioFirebaseModel{
    private let fModel : FirebaseModel
    // aqui se crea el constructor
    init(fModel: FirebaseModel = FirebaseModel()){
        self.fModel = fModel
    }
    
    func getUser() -> UserModel? { //nos devuelve el usuario y ese usuario esta en UserModel. verifica si el usurio esta activo y si es asi te deja entrar sin poner tu correo y contrasena otra vez
        fModel.getUser()
    }
    func createUser(email: String, password: String, completionBlock: @escaping(Result<UserModel, Error>) -> Void){ //crea usuario
        fModel.createUser(email: email, password: password, completionBlock: completionBlock)
    }
    func loginUser(email: String, password: String, completionBlock: @escaping(Result<UserModel, Error>) -> Void){ //crea usuario
        fModel.loginUser(email: email, password: password, completionBlock: completionBlock)
    }
    func logOutUser() throws { //cerrar sesion
        try fModel.logOutUser()
    }
}
