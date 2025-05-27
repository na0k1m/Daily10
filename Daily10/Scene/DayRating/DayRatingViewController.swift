//
//  ViewController.swift
//  Daily10
//
//  Created by 김나영 on 1/28/25.
//

import UIKit
import RealmSwift

class DayRatingViewController: UIViewController {
    @IBOutlet weak var dateTextLabel: UILabel!
    @IBOutlet weak var scoreView: RatingView!
    @IBOutlet weak var scoreTextLabel: UILabel!
    @IBOutlet weak var diaryTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var selectedDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var strSelectedDate = ""
        
        if let selectedDate = selectedDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "yy.MM.dd E"
            strSelectedDate = formatter.string(from: selectedDate)
            dateTextLabel.text = strSelectedDate
        } else {
            dateTextLabel.text = "날짜 없음"
        }
        
        let realm = try! Realm()
        let diaries = realm.objects(Diary.self)
        let selectedDateDiaries = diaries.filter("diaryDate == %@", strSelectedDate)
        let sortedSelectedDateDiaries = selectedDateDiaries.sorted(byKeyPath: "saveDate", ascending: false)
        let showDiary = sortedSelectedDateDiaries.first
        
        if let showDiary = showDiary {
            scoreView.score = Int(showDiary.score)
            scoreTextLabel.text = "\(scoreView.score)"
            diaryTextField.text = showDiary.diaryText
        }
        scoreView.delegate = self
    }
    
    @IBAction func onClickSave(_ sender: Any) {
        let realm = try! Realm()
        let inputDiary = Diary()
        
        inputDiary.id = UUID().uuidString
        inputDiary.saveDate = Date()
        inputDiary.diaryDate = dateTextLabel.text ?? ""
        inputDiary.score = Float(scoreView.score)
        inputDiary.diaryText = diaryTextField.text ?? ""
        
        try! realm.write {
            realm.add(inputDiary)
        }
        
        let diaries = realm.objects(Diary.self)
        for diary in diaries {
            print("\(diary.id), \(diary.saveDate), \(diary.diaryDate), \(diary.score), \(diary.diaryText)")
        }
        
        
        navigationController?.popViewController(animated: true)
    }
}

extension DayRatingViewController: RatingViewDelegate {
    func valueChanged(_ value: Int) {
        scoreTextLabel.text = "\(value)"
    }
}
