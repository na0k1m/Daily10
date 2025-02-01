//
//  CalendarViewController.swift
//  Daily10
//
//  Created by 김나영 on 1/30/25.
//

import UIKit

class CalendarViewController: UIViewController {
    
    lazy var dateView: UICalendarView = {
            var view = UICalendarView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.wantsDateDecorations = true
            return view
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
