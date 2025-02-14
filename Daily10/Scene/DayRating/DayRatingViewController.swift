//
//  ViewController.swift
//  Daily10
//
//  Created by 김나영 on 1/28/25.
//

import UIKit
import RealmSwift

class Diary: Object{
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var date: String = ""
    @objc dynamic var score: Float = 5.0
    @objc dynamic var diary: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
//    override init() {
//        id = ""
//        date = ""
//        score = 5.0
//        diary = ""
//    }
//    
//    init(id: String, date: String, score: Float, diary: String) {
//        self.id = id
//        self.date = date
//        self.score = score
//        self.diary = diary
//    }
}

class DayRatingViewController: UIViewController {
    @IBOutlet weak var dateTextLabel: UILabel!
    @IBOutlet weak var scoreSlider: UISlider!
    @IBOutlet weak var scoreTextLabel: UILabel!
    @IBOutlet weak var diaryTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yy.MM.dd E"
//        let strSelectedDate = formatter.string(from: selectedDate)
//        dateTextLabel.text = strSelectedDate
        if let selectedDate = selectedDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "yy.MM.dd E"
            let strSelectedDate = formatter.string(from: selectedDate)
            dateTextLabel.text = strSelectedDate
        } else {
            dateTextLabel.text = "날짜 없음"
        }
        
        //db에 save된 diary 정보를 dayrating view에다가 띄워야하는데 그걸 여러 diary정보중에 최신거를 띄워야 하는뎀
        
    }
    
    @IBAction func onScoreSlider(_ sender: UISlider) {
        let roundedScore = round(scoreSlider.value / 0.5) * 0.5
        scoreSlider.value = roundedScore
        
        scoreTextLabel.text = String(format: "%.1f", roundedScore)
    }
    
    @IBAction func onClickSave(_ sender: Any) {
        let realm = try! Realm()
        let diaryEntry = Diary()
        diaryEntry.id = UUID().uuidString
        diaryEntry.date = dateTextLabel.text ?? ""
        diaryEntry.score = scoreSlider.value
        diaryEntry.diary = diaryTextField.text ?? ""
        
        try! realm.write {
            realm.add(diaryEntry)
        }
        
        let diaries = realm.objects(Diary.self)
        for diary in diaries {
            print("\(diary.id), \(diary.date), \(diary.score), \(diary.diary)")
        }
        
        navigationController?.popViewController(animated: true)
    }
}

