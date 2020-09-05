//
//  TrailerViewController.swift
//  flixster
//
//  Created by Archit Jain on 9/4/20.
//  Copyright © 2020 archit. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movie_id = movie["id"] as! NSNumber
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie_id.stringValue)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let trailers = dataDictionary["results"] as! [[String:Any]]
                let key = trailers[0]["key"] as! String
                let url = URL(string: "https://www.youtube.com/watch?v=\(key)")
                let request = URLRequest(url: url!)
                print(request)
                self.webView.load(request)
            }
        }
        task.resume()
    }
}
