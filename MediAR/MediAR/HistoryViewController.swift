//
//  HistoryViewController.swift
//  MediAR
//
//  Created by Fletcher Marsh on 12/7/18.
//  Copyright © 2018 MediAR. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource {
    // Event info
    var events : [Event] = Event.getAll()
    let cellReuseIdentifier = "cell"
    
    // Interaction
    @IBOutlet var tableView: UITableView!
    
    // Asynchronously populate images
    func completeLoadAction(urlString: String, completion: @escaping (UIImage) -> ()) {
        let url = URL(string:urlString.trimmingCharacters(in: .whitespaces))
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                // Networking error
                return
            }
            print(urlString)
            let imgurImg = UIImage(data: data)
            completion(imgurImg!)
        }
        task.resume()
    }
    
    // Height of rows
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0;
    }
    
    // Title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Scans"
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    // Content of rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.events[indexPath.row].title
        completeLoadAction(urlString: "https://i.imgur.com/" + self.events[indexPath.row].imgurkey) { img in
            cell.imageView!.image = img
        }
        return cell
    }

    // MARK: Views
    
    override func viewDidLoad() {
        tableView.rowHeight = 150.0
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    // Change top bar back to default style for viewability
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
