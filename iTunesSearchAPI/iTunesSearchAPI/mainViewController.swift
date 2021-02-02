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

    @IBOutlet weak var tableView: UITableView!
    let test = ["one","two","three"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        loadTableViewCell()
        requestiTunesData()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func loadTableViewCell(){
        tableView.register(UINib(nibName: "customCell", bundle: nil), forCellReuseIdentifier: "customCell")

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! customCell

        cell.artistName.text = test[indexPath.row]
        return cell
    }
    func initTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    func requestiTunesData(){
        Alamofire.request(baseURL, method: .get, parameters: params).responseJSON { response in
            if (response.result.isSuccess) {
            } else {}
        }
    }
}
