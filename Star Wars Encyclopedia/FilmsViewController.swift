//
//  FilmsViewController.swift
//  Star Wars Encyclopedia
//
//  Created by Emily on 1/22/18.
//  Copyright © 2018 Emily. All rights reserved.
//


import UIKit
class FilmsViewController: UITableViewController {
    var films = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://swapi.co/api/films")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: {
            data, response, error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let results = jsonResult["results"]{
                        let resultsArray = results as! NSArray
                        for i in resultsArray{
                            let filmsDict = i as! NSDictionary
                            self.films.append(filmsDict["title"]! as! String)
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            } catch {
                print(error)
            }
        })
        task.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("FilmsViewController viewWillAppear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = films[indexPath.row]
        return cell
    }
}
