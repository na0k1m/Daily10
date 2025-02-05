//
//  ViewController.swift
//  Daily10
//
//  Created by 김나영 on 1/28/25.
//

import UIKit

class DayRatingViewController: UIViewController {
    @IBOutlet weak var dateTextLabel: UILabel!
    @IBOutlet weak var scoreSlider: UISlider!
    @IBOutlet weak var scoreTextLabel: UILabel!
    @IBOutlet weak var diaryTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd E"
        let date = formatter.string(from: Date())
        dateTextLabel.text = date
        
    }

    @IBAction func onDiaryTextField(_ sender: UITextField) {
        let diaryText = sender.text
        
    }
    
    @IBAction func onScoreSlider(_ sender: UISlider) {
        let roundedScore = round(scoreSlider.value / 0.5) * 0.5
        scoreSlider.value = roundedScore
        
        scoreTextLabel.text = String(format: "%.1f", roundedScore)
    }
    
    @IBAction func onClickSave(_ sender: Any) {
//        let viewController = UIViewController.getViewController(viewControllerEnum: .calendar)
//        navigationController?.pushViewController(viewController, animated: true)
    }
}

