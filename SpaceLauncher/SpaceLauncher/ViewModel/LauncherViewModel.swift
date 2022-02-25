//
//  LauncherViewModel.swift
//  SpaceLauncher
//
//  Created by 922235 on 25/02/22.
//

import Foundation
import UIKit

class LauncherViewModel: UIViewController{
    
    var launcherResponse: LauncherResponse?
    var responseById: ResponseById?
    var apiCallUrl = ""
    
    typealias CompletionHandler = (Bool) -> Void
    typealias imageCompletionHandler = (Data, Bool) -> Void
    
    
    // API call to fetch Astronaut list and Astronaut details by id
    func fetchDetailedList(idValue: Int?, completionHandler: @escaping CompletionHandler) {
        
        if idValue == nil{
            apiCallUrl = String(Utilities.urlString.astronautListFetchUrl)
        }else{
            apiCallUrl = String(format: Utilities.urlString.astronautDetailFetchUrl, String(idValue!))
        }
        let url = URL(string: apiCallUrl)!
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                if idValue == nil{
                    let result = try JSONDecoder.init().decode(LauncherResponse.self, from: data)
                    self.launcherResponse = result
                    completionHandler(true)
                }else{
                    let result = try JSONDecoder.init().decode(ResponseById.self, from: data)
                    self.responseById = result
                    completionHandler(true)
                }
            } catch {
                print(error)
                completionHandler(false)
            }
        }
        task.resume()
    }
    
    // Network operation to load image from URL
    func fetchImageFromURL(fetchUrl: String, completionHandler: @escaping imageCompletionHandler) {
        
        if let url = URL(string: fetchUrl) {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                completionHandler(data, true)
            }
            task.resume()
        }
    }
}

extension LauncherViewModel: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}
