import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        let window = UIWindow(windowScene: windowScene)
        
        let coordinator = Coordinator(rootScreen: .charactersList)
        
        window.rootViewController = coordinator.navigationController
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}
