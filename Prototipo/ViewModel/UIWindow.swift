//
//  UIWindow.swift
//  Prototipo
//
//  Created by Sibel Rodriguez on 10/12/25.
//

import Foundation
import UIKit

extension UIApplication {
    func topViewController() -> UIViewController? {
        guard let scene = connectedScenes.first as? UIWindowScene,
              let root = scene.windows.first?.rootViewController else {
            return nil
        }

        var top = root
        while let presented = top.presentedViewController {
            top = presented
        }
        return top
    }
}
