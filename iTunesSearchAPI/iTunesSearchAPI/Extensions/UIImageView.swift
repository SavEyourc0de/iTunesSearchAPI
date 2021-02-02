//
//  UIImage.swift
//  iTunesSearchAPI
//
//  Created by Xavier Johanis Elnas on 02/02/2021.
//  Copyright © 2021 Xavier Johanis Elnas. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setCornerRadius(image: UIImageView){
        image.layer.cornerRadius = 5
        image.layer.masksToBounds = true
    }

    // Mark: Load image URL
    /*
    load image from remote acquired from github user(cagdaseksi): https://github.com/SavEyourc0de/letslearnswift/blob/master/LoadRemoteImageUrl/LoadRemoteImageUrl/ViewController.swift
    */
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
