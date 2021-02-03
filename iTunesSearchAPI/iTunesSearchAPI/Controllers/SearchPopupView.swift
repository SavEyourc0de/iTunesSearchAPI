//
//  SearchPopupView.swift
//  iTunesSearchAPI
//
//  Created by Xavier Johanis Elnas on 04/02/2021.
//  Copyright © 2021 Xavier Johanis Elnas. All rights reserved.
//

import UIKit

protocol searchPopupViewDelegate {
    func didTapSearch (data: String)
}

class SearchPopupView: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchContainer: UIView!
    @IBOutlet weak var searchButton: UIButton!
    
    var delegate: searchPopupViewDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        // Do any additional setup after loading the view.
    }
    func initView(){
        searchTextField.delegate = self
        searchContainer.layer.cornerRadius = 5
        searchContainer.layer.masksToBounds = true
    }
    @IBAction func searchButton(_ sender: Any) {
        delegate.didTapSearch(data: searchTextField.text!)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func dismissPopupView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
