//
//  SpinnerViewController.swift
//  SpaceLauncher
//
//  Created by 922235 on 25/02/22.
//

import UIKit

class SpinnerViewController: UIViewController {
    
    var spinner = UIActivityIndicatorView(style: .large)

        override func loadView() {
            view = UIView()
            view.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
            spinner.translatesAutoresizingMaskIntoConstraints = false
            spinner.startAnimating()
            view.addSubview(spinner)

            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }

}
