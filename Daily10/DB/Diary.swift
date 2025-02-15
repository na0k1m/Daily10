//
//  Diary.swift
//  Daily10
//
//  Created by 김나영 on 2/15/25.
//

import Foundation
import RealmSwift

class Diary: Object{
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var saveDate: Date = Date()
    @objc dynamic var diaryDate: String = ""
    @objc dynamic var score: Float = 5.0
    @objc dynamic var diaryText: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
