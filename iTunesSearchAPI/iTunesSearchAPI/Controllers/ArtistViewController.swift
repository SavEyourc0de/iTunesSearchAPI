//
//  ArtistViewController.swift
//  iTunesSearchAPI
//
//  Created by Xavier Johanis Elnas on 03/02/2021.
//  Copyright © 2021 Xavier Johanis Elnas. All rights reserved.
//

import UIKit
import RealmSwift

class ArtistViewController: UIViewController {
    @IBOutlet weak var artwork: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var longDescription: UITextView!
    @IBOutlet weak var price: UIButton!
    
    let realm = try! Realm()
    var artistViewModel: ArtistViewModel?
    var artistRealmModel = ArtistViewModelRealm()
    var artistData = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    // Mark: Load Data to View
    func loadData() {
        artwork.load(url: ((artistViewModel?.artworkUrl)?.absoluteURL)!)
        artistName.text = (artistViewModel?.artistName)!
        collectionName.text = (artistViewModel?.collectionName)!
        genre.text = (artistViewModel?.primaryGenreName)!
        longDescription.text = (artistViewModel?.longDescription)!
        price.setTitle("\(artistViewModel!.currency) \(artistViewModel!.trackPrice)", for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        loadRealmData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        deleteRealmData()
    }
    // Mark: -Store REALM data from `artistViewModel`
    // This is key so:
    //      1) when app is closed there is data stored in Realm
    //      2) upon opening the app again will check if there is existing data then proceeds to artist view otherwise will start the app normally
    func loadRealmData(){
        artistRealmModel.artworkUrl = artistViewModel?.artworkUrl.absoluteString
        artistRealmModel.artistName = artistViewModel?.artistName
        artistRealmModel.collectionName = artistViewModel?.collectionName
        artistRealmModel.primaryGenreName = artistViewModel?.primaryGenreName
        artistRealmModel.longDescription = artistViewModel?.longDescription
        artistRealmModel.trackPrice = (artistViewModel?.trackPrice)!
        artistRealmModel.currency = artistViewModel?.currency
        
        do {
            try realm.write {
                realm.add(artistRealmModel)
            }
        } catch {
            print("error:\(error)")
        }
    }
    // Mark: -Delete Realm Data
    // removes all data from Realm so upon opening the app, it wont transition to this view.
    func deleteRealmData(){
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("error:\(error)")
        }
    }
}
