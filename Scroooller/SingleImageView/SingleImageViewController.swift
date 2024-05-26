//
//  SingleImageViewController.swift
//  Scroooller
//
//  Created by Виктория Демченко on 18.05.24.
//

import UIKit

final class SingleImageViewController: UIViewController {
    var image: UIImage?{
        didSet {
            guard isViewLoaded else { return }
            ImageView.image = image
        }
    }
    
    @IBOutlet private var ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageView.image = image
    }
}
