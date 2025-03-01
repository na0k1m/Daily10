//
//  DateCollectionViewCell.swift
//  Daily10
//
//  Created by 김나영 on 2/1/25.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var circleDateView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
        
    func setCircle() {
        layoutIfNeeded()
        circleDateView.layer.cornerRadius = circleDateView.frame.width / 2
    }
}
