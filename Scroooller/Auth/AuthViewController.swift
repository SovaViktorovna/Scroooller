//
//  AuthViewController.swift
//  Scroooller
//
//  Created by Виктория Демченко on 10.06.24.
//

import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func didAuthenticate(_ vc: AuthViewController)
}

final class AuthViewController: UIViewController {
    private let ShowWebViewSegueIdentifier = "ShowWebView"
    
    weak var delegate: AuthViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("AuthViewController -> viewDidLoad")
        
        configureBackButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        print("AuthViewController -> prepare")
        if segue.identifier == ShowWebViewSegueIdentifier {
            guard
                let webViewViewController = segue.destination as? WebViewViewController
            else { fatalError("Failed to prepare for \(ShowWebViewSegueIdentifier)") }
            
            print("AuthViewController -> prepare -> segue ok, delegate self")
            
            webViewViewController.delegate = self
        } else {
            print("AuthViewController -> prepare -> segue when not a ShowWebViewSegueIdentifier")
            super.prepare(for: segue, sender: sender)
        }
    }
    
    func handleCodeResult(result: Result<String, Error>) {
        print("handleCodeResult")
        switch result {
        case .success(_): do {
                print("handleCodeResult success")
                DispatchQueue.main.async {
                    self.delegate?.didAuthenticate(self)
                }
            }
            case .failure(let error): do {
                print("handleCodeResult failure")
                print("Error when try to get access code: \(error)")
            }
        }
    }
        
        func configureBackButton() {
            navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Nav_back_button")
            navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "nav_back_button")
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            navigationItem.backBarButtonItem?.tintColor = UIColor(named: "YP Black")
            print("configureBackButton end")
        }
    }
    
    extension AuthViewController: WebViewViewControllerDelegate {
        func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
            print("AuthViewController")
            vc.dismiss(animated: true)
            OAuth2Service.shared.fetchOAuthToken(code: code, handler: handleCodeResult)
             
            
        }
        func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
            dismiss(animated: true)
        }
    }
    
