//
//  HistoryViewController.swift
//  MediAR
//
//  Created by Fletcher Marsh on 12/7/18.
//  Copyright © 2018 MediAR. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource {
    var events : [Event] = Event.getAll()
    let cellReuseIdentifier = "cell"
    
    @IBOutlet var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 150.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Scans"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func completeLoadAction(urlString:String, completion: @escaping (UIImage) -> ()) {
        let url = URL(string:urlString.trimmingCharacters(in: .whitespaces))
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                DispatchQueue.main.async {

                }
                return
            }
            let imgurImg = UIImage(data: data)
            let httpStatus = response as? HTTPURLResponse
            let httpStatusCode:Int = (httpStatus?.statusCode)!
            
            DispatchQueue.main.async {
                
            }
            completion(imgurImg!)
        }
        task.resume()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.events[indexPath.row].title
        completeLoadAction(urlString: "https://i.imgur.com/" + self.events[indexPath.row].imgurkey) { img in
            
            cell.imageView!.image = img
            
        }
        return cell
    }

    override func viewDidLoad() {
        tableView.rowHeight = 150.0
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
