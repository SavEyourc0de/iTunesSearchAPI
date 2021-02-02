//
//  ArtistViewController.swift
//  iTunesSearchAPI
//
//  Created by Xavier Johanis Elnas on 03/02/2021.
//  Copyright © 2021 Xavier Johanis Elnas. All rights reserved.
//

import UIKit

class ArtistViewController: UIViewController {
    @IBOutlet weak var artwork: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var longDescription: UITextView!
    @IBOutlet weak var price: UIButton!
    

    var artistViewModel: ArtistViewModel?
    var artistData = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        //loadData()
    }
    
    func loadData() {
        artwork.load(url: (artistViewModel?.artworkUrl)!)
        artistName.text = (artistViewModel?.artistName)!
        collectionName.text = (artistViewModel?.collectionName)!
        genre.text = (artistViewModel?.primaryGenreName)!
        longDescription.text = (artistViewModel?.longDescription)!
        price.setTitle("\(artistViewModel!.currency) \(artistViewModel!.trackPrice)", for: .normal)
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
