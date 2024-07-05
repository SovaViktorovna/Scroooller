//
//  AuthViewController.swift
//  Scroooller
//
//  Created by Виктория Демченко on 10.06.24.
//

import UIKit

final class AuthViewController: UIViewController {
    private let ShowWebViewSegueIdentifier = "ShowWebView"

    override func viewDidLoad() {
        configureBackButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == ShowWebViewSegueIdentifier {
            guard
                let webViewViewController = segue.destination as? WebViewViewController
            else { fatalError("Failed to prepare for \(ShowWebViewSegueIdentifier)") }
            webViewViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    func handleCodeResult(result: Result<Data, Error>){
        let decoder = JSONDecoder()
        switch result {
           case .success(let data):
               do {
                   let response = try decoder.decode(OAuthTokenResponseBody.self, from: data)
                   // Обработка успешного декодирования
                   print("Decoded response: \(response)")
                   OAuth2TokenStorage.shared.token = response.access_token
                   
               } catch {
                   // Обработка ошибки декодирования
                   print("Failed to decode JSON: \(error)")
               }
           case .failure(let error):
               // Обработка ошибки
               print("Request failed with error: \(error)")
           }
    }
    
    func saveOAuthData(responseBody: OAuthTokenResponseBody){
        
    }
    
    func configureBackButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Nav_back_button")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "nav_back_button")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor(named: "YP Black")
    }
}

extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        print("AuthViewController")
        OAuth2Service.shared.fetchOAuthToken(code: code, handler: handleCodeResult)
    }
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        dismiss(animated: true)
    }
}

