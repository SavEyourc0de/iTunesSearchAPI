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

                //UserDefaults.standard.set(true, forKey: "localData")
            }
        } catch {
            print("error:\(error)")
        }
    }
    func deleteRealmData(){
        do {
            try realm.write {
                realm.deleteAll()

                //UserDefaults.standard.set(false, forKey: "localData")
            }
        } catch {
            print("error:\(error)")
        }
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
