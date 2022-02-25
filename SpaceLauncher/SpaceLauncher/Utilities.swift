//
//  Utilities.swift
//  SpaceLauncherTests
//
//  Created by 922235 on 25/02/22.
//

import Foundation
import UIKit

class Utilities {
    
    struct urlString {
        static let astronautListFetchUrl = "http://spacelaunchnow.me/api/3.5.0/astronaut/"
        static let astronautDetailFetchUrl = "http://spacelaunchnow.me/api/3.5.0/astronaut/%@"
    }
    
    // add spinnerview to display loading indicator
    static func addSpinnerView(spinner: SpinnerViewController, on parentView: UIViewController) {
        parentView.addChild(spinner)
        spinner.view.frame = parentView.view.frame
        parentView.view.addSubview(spinner.view)
        spinner.didMove(toParent: parentView)
    }
    
    // Remove spinnerview
    static func removeSpinnerView(spinner: SpinnerViewController, on parentView: UIViewController) {
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
    
    // Date and time formatter
    static func convertDateFormat(inputDate: String) -> String {
        
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let oldDate = olDateFormatter.date(from: inputDate)
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "MMM dd yyyy h:mm a"
        return convertDateFormatter.string(from: oldDate!)
    }
    
    static func showSimpleAlert(message: String, title: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alert.addAction(alertAction)
        return alert
    }

    
}
