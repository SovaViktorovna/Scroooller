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
        
        if let token = OAuth2TokenStorage.shared.token{
            switchToTabBarController()
        } else {
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
        if segue.identifier == showAuthenticationScreen {
            
            // Доберёмся до первого контроллера в навигации. Мы помним, что в программировании отсчёт начинается с 0?
            guard
                let navigationController = segue.destination as? UINavigationController,
                let viewController = navigationController.viewControllers[0] as? AuthViewController
            else {
                assertionFailure("Failed to prepare for \(showAuthenticationScreen)")
                return
            }
            
            // Установим делегатом контроллера наш SplashViewController
            viewController.delegate = self
            
        } else {
            super.prepare(for: segue, sender: sender)
           }
    }
}
