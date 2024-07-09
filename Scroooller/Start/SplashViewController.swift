//
//  SplashViewController.swift
//  Scroooller
//
//  Created by Виктория Демченко on 05.07.24.
//

import UIKit
final class SplashViewController: UIViewController, AuthViewControllerDelegate {
    private let showAuthenticationScreen = "ShowAuthenticationScreen"
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        print("SplashViewController viewDidAppear")
      
//        print(OAuth2TokenStorage.shared.token!)
        if OAuth2TokenStorage.shared.token != nil {
            print("SplashViewController no token")
            switchToTabBarController()
        } else {
            print("SplashViewController has token")
            performSegue(withIdentifier: showAuthenticationScreen, sender: nil)
        }
    }
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
        window.rootViewController = tabBarController
    }
}

extension SplashViewController {
    func didAuthenticate(_ vc: AuthViewController){
        vc.dismiss(animated: true)
        switchToTabBarController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Проверим, что переходим на авторизацию
        print("SplashViewController -> prepare")
        print(segue.identifier ?? "no identifier")
        if segue.identifier == showAuthenticationScreen {
            guard
                let navigationController = segue.destination as? UINavigationController,
                let viewController = navigationController.viewControllers[0] as? AuthViewController
            else {
                assertionFailure("Failed to prepare for \(showAuthenticationScreen)")
                return
            }
            
            print("SplashViewController -> prepare -> set delegate")
            viewController.delegate = self
            
        } else {
            print("SplashViewController -> prepare -> perform another segue")
            super.prepare(for: segue, sender: sender)
           }
    }
}
