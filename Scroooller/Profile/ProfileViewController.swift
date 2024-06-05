//
//  ProfileViewController.swift
//  Scroooller
//
//  Created by Виктория Демченко on 17.05.24.
//

import UIKit

final class ProfileViewController: UIViewController {
    override func viewDidLoad(){
        super.viewDidLoad()
        
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Profile_Foto")
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 76).isActive = true
        
        let nameLabel = UILabel()
        nameLabel.text = "Екатерина Новикова"
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        
        let accountNameLabel = UILabel()
        accountNameLabel.text = "@ekaterina_nov"
        accountNameLabel.textColor = .ypGray
        accountNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(accountNameLabel)
        accountNameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        accountNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Hello, world!"
        descriptionLabel.textColor = .white
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: accountNameLabel.bottomAnchor, constant: 8).isActive = true
        
        
        let button = UIButton()
        let buttonImage = UIImage(named: "Exit_Image")
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        button.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
    }
}
