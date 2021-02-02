//
//  mainViewController.swift
//  iTunesSearchAPI
//
//  Created by Xavier Johanis Elnas on 02/02/2021.
//  Copyright © 2021 Xavier Johanis Elnas. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class mainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let baseURL = "https://itunes.apple.com/search?"
    let params = ["term":"moon",
                  "country":"au",
                  "media":"movie",
                  "all":""]
    var data: [ArtistItem] = []

    @IBOutlet weak var tableView: UITableView!
    let test = ["one","two","three"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        loadTableViewCell()
        requestiTunesData()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation
    func loadTableViewCell(){
        tableView.register(UINib(nibName: "customCell", bundle: nil), forCellReuseIdentifier: "customCell")

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! customCell

        cell.artistName.text = data[indexPath.row].artistName
        cell.trackName.text = data[indexPath.row].trackName
        cell.price.text = "\(data[indexPath.row].currency) \(data[indexPath.row].trackPrice)"
        cell.albumArtwork.load(url: data[indexPath.row].artworkUrl)
        return cell
    }
    func initTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    func requestiTunesData(){
        Alamofire.request(baseURL, method: .get, parameters: params).responseJSON { response in
            if (response.result.isSuccess) {
                let json = JSON(response.result.value)
                self.data = ArtistModel(json: json).artistItems
                self.tableView.reloadData()
            } else {}
        }
    }
}
