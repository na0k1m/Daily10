//
//  Date+Extension.swift
//  Daily10
//
//  Created by 김나영 on 2/15/25.
//

import Foundation

extension Date {
    var koreaTime: String {
        let koreaFormatter = DateFormatter()
        koreaFormatter.locale = Locale(identifier: "ko_KR")
        koreaFormatter.dateFormat = "yy.MM.dd HH:mm"
        return koreaFormatter.string(from: self)
    }
}
