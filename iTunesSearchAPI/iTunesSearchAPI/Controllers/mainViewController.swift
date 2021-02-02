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
    var artistViewmodel: ArtistViewModel?
    var artistViewController: ArtistViewController?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewController()
        initTableView()
        loadTableViewCell()
        requestiTunesData()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - TableView
    func initTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ArtistViewController") as! ArtistViewController

        artistViewmodel = ArtistViewModel(trackId: data[indexPath.row].trackId, artistName: data[indexPath.row].artistName, collectionName: data[indexPath.row].collectionName, trackName: data[indexPath.row].trackName, artworkUrl: data[indexPath.row].artworkUrl, trackPrice: data[indexPath.row].trackPrice, releaseDate: data[indexPath.row].releaseDate, currency: data[indexPath.row].currency, primaryGenreName: data[indexPath.row].primaryGenreName, longDescription: data[indexPath.row].longDescription)
    
        vc.artistViewModel = artistViewmodel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // Mark: - Request Data
    func requestiTunesData(){
        Alamofire.request(baseURL, method: .get, parameters: params).responseJSON { response in
            if (response.result.isSuccess) {
                let json = JSON(response.result.value)
                self.data = ArtistModel(json: json).artistItems
                self.tableView.reloadData()

            } else {}
        }
    }
    func loadViewController(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ArtistViewController") as! ArtistViewController
    }
}
