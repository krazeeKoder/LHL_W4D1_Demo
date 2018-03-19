//
//  ViewController.swift
//  LHL_W4D1
//
//  Created by Anthony Tulai on 2018-03-19.
//  Copyright © 2018 Anthony Tulai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var repoNames = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath)
        
        cell.textLabel?.text = repoNames[indexPath.row]
        
        return cell
    }
    
    @IBOutlet weak var repoTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.repoTableView.delegate = self
        self.repoTableView.dataSource = self
        
        self.fetchData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func fetchData() {
        guard let url = URL(string: "https://swapi.co/api/starships/") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let jsonUnformatted = try? JSONSerialization.jsonObject(with: data!, options: []) {
                if let jsonDictionary = jsonUnformatted as? [String: Any] {
                    if let results = jsonDictionary["results"] as? [[String: Any]] {
                        for starship in results {
                            if let name = starship["name"] as? String {
                                self.repoNames.append(name)
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.repoTableView.reloadData()
                    }
                }
            }
        }
        
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

