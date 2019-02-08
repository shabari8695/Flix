//
//  TrailerViewController.swift
//  Flix
//
//  Created by Shabari Girish Ganapathy on 2/8/19.
//  Copyright © 2019 Shabari Girish Ganapathy. All rights reserved.
//

import UIKit
import AlamofireImage
class TrailerViewController: UIViewController {

    var movie = [String:Any]()
    var trailers = [[String:Any]]()
    var trailer = [String:Any]()
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let id = movie["id"]!
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.trailers = dataDictionary["results"] as! [[String:Any]]
                self.trailer = self.trailers[0]
                let key = self.trailer["key"]
                
                let video = "https://www.youtube.com/watch?v=\(key)"
                //print(self.trailer["key"]!)
                let video_url = URL(string: video)
                self.webView.loadRequest(URLRequest(url: video_url!))
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
            }
        }
        task.resume()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
