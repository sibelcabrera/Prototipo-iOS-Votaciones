//
//  LogoView.swift
//  Prototipo
//
//  Created by user278672 on 9/28/25.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        ZStack(){
            //RadialGradient(gradient: Gradient(colors: [Color("Color4"), Color("Color2"), Color("Color3"), Color("Color1")]), center: .center, startRadius: 50, endRadius: 900)
            LinearGradient(gradient: Gradient(colors: [Color("Color1"), Color("Color3"), Color("Color3"), Color("Color1")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(){
                Image("logo2")
            }
        }
    }
}

#Preview {
    LogoView()
}
