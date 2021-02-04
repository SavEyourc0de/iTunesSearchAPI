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
import RealmSwift

class mainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, searchPopupViewDelegate {
    
    let realm = try! Realm()
    var params = [API_CONSTANTS.PARAMETERS.TERM:"moon",
                  API_CONSTANTS.PARAMETERS.COUNTRY.KEY:API_CONSTANTS.PARAMETERS.COUNTRY.VALUE,
                  API_CONSTANTS.PARAMETERS.MEDIA.KEY:API_CONSTANTS.PARAMETERS.MEDIA.VALUE,
                  "all":""]
    var data: [ArtistItem] = []
    var artistViewmodel: ArtistViewModel?
    var artistViewController: ArtistViewController?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmData()
        initTableView()
        loadTableViewCell()
        requestiTunesData()
    }
    
    // MARK: - Remove Navigation Bar
    //Hide navigation bar upon viewing screen, enable upon dissappear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - TableView: Load TableView
    func initTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    func loadTableViewCell(){
        tableView.register(UINib(nibName: Identifiers.CUSTOM_CELL.MAIN_TABLEVIEW_CUSTOMCELL, bundle: nil), forCellReuseIdentifier: Identifiers.CUSTOM_CELL.MAIN_TABLEVIEW_CUSTOMCELL)

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.CUSTOM_CELL.MAIN_TABLEVIEW_CUSTOMCELL, for: indexPath) as! customCell

        cell.artistName.text = data[indexPath.row].artistName
        cell.trackName.text = data[indexPath.row].trackName
        cell.price.text = "\(data[indexPath.row].currency) \(data[indexPath.row].trackPrice)"
        cell.albumArtwork.load(url: data[indexPath.row].artworkUrl)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: Identifiers.VIEWCONTROLLERS.ARTISTVIEWCONTROLLER) as! ArtistViewController

        artistViewmodel = ArtistViewModel(trackId: data[indexPath.row].trackId, artistName: data[indexPath.row].artistName, collectionName: data[indexPath.row].collectionName, trackName: data[indexPath.row].trackName, artworkUrl: data[indexPath.row].artworkUrl, trackPrice: data[indexPath.row].trackPrice, releaseDate: data[indexPath.row].releaseDate, currency: data[indexPath.row].currency, primaryGenreName: data[indexPath.row].primaryGenreName, longDescription: data[indexPath.row].longDescription)
    
        vc.artistViewModel = artistViewmodel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // Mark: - Request Data -- Load Data
    func requestiTunesData(){
        Alamofire.request(API_CONSTANTS.URL.BASE_URL, method: .get, parameters: params).responseJSON { response in
            if (response.result.isSuccess) {
                let json = JSON(response.result.value)
                self.data = ArtistModel(json: json).artistItems
                self.tableView.reloadData()

            } else {
                print(response.result.error)
            }
        }
    }
    // MARK: LOAD REALM
    //Load data from REALM
    //IF Empty/NIL return otherwise Transition to previous Artist View(after the app was closed)
    func realmData() {
        let vc = storyboard?.instantiateViewController(withIdentifier: Identifiers.VIEWCONTROLLERS.ARTISTVIEWCONTROLLER) as! ArtistViewController
        
        guard let data = realm.objects(ArtistViewModelRealm.self).first else { return }

        artistViewmodel = ArtistViewModel(trackId: 0.0, artistName: data.artistName!, collectionName: data.collectionName ?? "", trackName: data.trackName ?? "", artworkUrl: URL(string: data.artworkUrl!)!, trackPrice: data.trackPrice, releaseDate: data.releaseDate ?? "", currency: data.currency!, primaryGenreName: data.primaryGenreName!, longDescription: data.longDescription!)

        vc.artistViewModel = artistViewmodel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: SearchArtist
    //after search reload tableview container related search data
    @IBAction func searchArtist(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: Identifiers.VIEWCONTROLLERS.SEARCH_POPUPVIEW) as! SearchPopupView
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    func didTapSearch(data: String) {
        params = [API_CONSTANTS.PARAMETERS.TERM:data,
                  API_CONSTANTS.PARAMETERS.COUNTRY.KEY:API_CONSTANTS.PARAMETERS.COUNTRY.VALUE,
                  API_CONSTANTS.PARAMETERS.MEDIA.KEY:API_CONSTANTS.PARAMETERS.MEDIA.VALUE,
                  "all":""]
        requestiTunesData()
        tableView.reloadData()
    }
}
