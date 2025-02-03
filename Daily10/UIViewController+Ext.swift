//
//  UIViewController+Ext.swift
//  Daily10
//
//  Created by 김나영 on 2/1/25.
//

import Foundation
import UIKit

// MARK: - Public Outter Class, Struct, Enum, Protocol
enum ViewControllerEnum: String, CaseIterable {
    case dayRating
    case calendar
}

extension UIViewController {

    // MARK: - Public Method
    class func getViewController(viewControllerEnum: ViewControllerEnum) -> UIViewController {
        switch viewControllerEnum {
        case .dayRating:
            return getViewController(storyboard: "DayRating", identifier: String(describing: DayRatingViewController.self), modalPresentationStyle: .fullScreen)
        case .calendar:
            return getViewController(storyboard: "Calendar", identifier: String(describing: CalendarViewController.self), modalPresentationStyle: .fullScreen)
        }
    }
    
    // MARK: - Private Method
    private class func getViewController(storyboard: String, identifier: String, modalPresentationStyle: UIModalPresentationStyle) -> UIViewController {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: identifier)
        vc.modalPresentationStyle = modalPresentationStyle
        return vc
    }
}
