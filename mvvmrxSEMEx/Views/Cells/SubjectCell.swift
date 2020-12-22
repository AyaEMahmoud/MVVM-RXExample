//
//  SubjectCell.swift
//  mvvmrxSEMEx
//
//  Created by Aya Essam on 12/7/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import UIKit
import Kingfisher

class SubjectCell: UICollectionViewCell {
    
    @IBOutlet private weak var subjectTitle: UILabel!
    @IBOutlet private weak var subjectImage: UIImageView!
    @IBOutlet private weak var view: UIView!
    
    override func awakeFromNib() {
         super.awakeFromNib()
        view.layer.cornerRadius = 7
     }
    
    func setCellData(subject: Subjects) {
        subjectTitle.text = subject.title
        if let imageString = subject.file?.path, let url = URL(string: APPURL.StorageURL + imageString) {
            subjectImage.kf.setImage(with: url)
        } else {
            subjectImage.image = UIImage(named: "ic_icon")
        }
    }
}
