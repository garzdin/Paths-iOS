//
//  TableViewController.swift
//  Paths
//
//  Created by Teodor on 13/11/2016.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewController: UITableViewController {
    
    var objects: [Path] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl?.addTarget(self, action: #selector(TableViewController.loadData), for: UIControlEvents.valueChanged)
        loadData()
    }
    
    func loadData() {
        getData { paths in
            self.objects = paths
            if self.refreshControl?.isRefreshing == true {
                self.refreshControl?.endRefreshing()
            }
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pathCell", for: indexPath)
        cell.textLabel?.text = objects[indexPath.row].name
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showDetail") {
            let next = segue.destination as? ViewController
            if let index = self.tableView.indexPathForSelectedRow {
                next?.object = objects[index.row]
            }
        }
    }
    
    func getData(completion: @escaping ([Path]) -> ()) {
        apiCall(completion: completion)
    }
    
    func apiCall(completion: @escaping ([Path]) -> ()) {
        var objects: [Path] = []
        Alamofire.request("http://192.168.7.192:8888/api/v1/paths/").responseJSON { response in
            if let rawJson = response.result.value {
                let json = JSON(rawJson)
                if let data = json.dictionary {
                    if let paths = data["paths"] {
                        for (_,path):(String,JSON) in paths {
                            if let id = path["id"].int, let name = path["name"].string, let description = path["description"].string {
                                let object = Path(id: id, name: name, description: description)
                                var pois: [POI] = []
                                for (_,poi) in path["pois"] {
                                    if let poiId = poi["id"].int, let poiName = poi["name"].string, let poiLatitude = poi["latitude"].float, let poiLongitude = poi["longitude"].float {
                                        let poiEntry = POI(id: poiId, name: poiName, latitude: poiLatitude, longitude: poiLongitude)
                                        pois.append(poiEntry)
                                    }
                                }
                                object.pois = pois
                                objects.append(object)
                            }
                        }
                        completion(objects)
                    }
                }
            }
        }
    }
}
