//
//  CalendarViewController.swift
//  Daily10
//
//  Created by 김나영 on 1/30/25.
//

import UIKit
import RealmSwift

class CalendarViewController: UIViewController {
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var yearMonthLabel: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    private let now = Date()
    private var calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    private var components = DateComponents()
    private var weeks: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    private var days: [String] = []
    private var daysCountInMonth = 0
    private var weekdayAdding = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarCollectionView.register(UINib(nibName: String(describing: DateCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: DateCollectionViewCell.self))
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
        
        dateFormatter.dateFormat = "yyyy.MM"
        components.year = calendar.component(.year, from: now)
        components.month = calendar.component(.month, from: now)
        components.day = 1
        
        calNumOfDaysInMonth()
    }
    
    private func calNumOfDaysInMonth() {
        guard let firstDayOfMonth = calendar.date(from: components) else { return }
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        daysCountInMonth = calendar.range(of: .day, in: .month, for: firstDayOfMonth)!.count
        weekdayAdding = 2 - firstWeekday
        
        self.yearMonthLabel.text = dateFormatter.string(from: firstDayOfMonth)
        self.days.removeAll()
        
        for day in weekdayAdding...daysCountInMonth {
            if day < 1 {
                self.days.append("")
            }
            else {
                self.days.append(String(day))
            }
        }
    }
    
    @IBAction func onClickPrev(_ sender: UIButton) {
        components.month = components.month! - 1
        self.calNumOfDaysInMonth()
        self.calendarCollectionView.reloadData()
    }
    
    @IBAction func onClickNext(_ sender: UIButton) {
        components.month = components.month! + 1
        self.calNumOfDaysInMonth()
        self.calendarCollectionView.reloadData()
    }
}

extension CalendarViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 7
        default:
            return self.days.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DateCollectionViewCell
        if let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DateCollectionViewCell.self), for: indexPath) as? DateCollectionViewCell {
            cell = reusableCell
        } else {
            let objectArray = Bundle.main.loadNibNamed(String(describing: DateCollectionViewCell.self), owner: nil, options: nil)
            cell = objectArray![0] as! DateCollectionViewCell
        }
        cell.setCircle()
        switch indexPath.section {
        case 0:
            cell.dateLabel.text = weeks[indexPath.row]
        default:
            cell.dateLabel.text = days[indexPath.row]
        }
        
        if indexPath.row % 7 == 0 {
            cell.dateLabel.textColor = .red
        }
        else if indexPath.row % 7 == 6 {
            cell.dateLabel.textColor = .blue
        }
        else {
            cell.dateLabel.textColor = .black
        }
        
        switch indexPath.section {
        case 0:
            cell.circleDateView.backgroundColor = .clear
            break
        default:
            // text-> nil
            //     - clear
            // text-> nil X
            //     - isEmpty = true -> clear
            //     - isEmpty = false -> color
            
            guard let isEmpty = cell.dateLabel.text?.isEmpty, !isEmpty else {
                cell.circleDateView.backgroundColor = .clear
                break
            }
//            cell.circleDateView.backgroundColor = .green
            
            
            // 요일도 필요/ diaryDate 가 "yy.MM.dd E" 이 형식의 string임
            guard let dayText = cell.dateLabel.text, !dayText.isEmpty else { // 날짜만 비교하고잇음 달도 비교해야하는데
                break
            }
            let formattedDayText = String(format: "%02d", Int(dayText) ?? 0)
            
            let formattedDateString = String(format: "%02d.%02d.%@ %@", components.year! % 100, components.month!, formattedDayText, weeks[indexPath.row % 7])
//            print(formattedDateString)
            
            let realm = try! Realm()
            let diaries = realm.objects(Diary.self)
            let selectedDateDiaries = diaries.filter("diaryDate == %@", formattedDateString)
            let sortedSelectedDateDiaries = selectedDateDiaries.sorted(byKeyPath: "saveDate", ascending: false)
            let showDiary = sortedSelectedDateDiaries.first
            
//            if let score = showDiary?.score {
//                switch score {
            if let showDiary = showDiary {
                switch showDiary.score {
                case 0...2:
                    cell.circleDateView.backgroundColor = UIColor(hex: 0xE9F3FD) // 95
                case 3...4:
                    cell.circleDateView.backgroundColor = UIColor(hex: 0xD1E5FB) // 90
                case 5:
                    cell.circleDateView.backgroundColor = UIColor(hex: 0xB7D6F9) // 85
                case 6...7:
                    cell.circleDateView.backgroundColor = UIColor(hex: 0x8CBDF5) // 75
                case 8...9:
                    cell.circleDateView.backgroundColor = UIColor(hex: 0x5AA0F1) // 65
                case 10:
                    cell.circleDateView.backgroundColor = UIColor(hex: 0x1679EB) // 50
                default:
                    cell.circleDateView.backgroundColor = UIColor(hex: 0xD7D7D7) // 회
                }
            } else {
//                cell.circleDateView.backgroundColor = UIColor(hex: 0xF0F0F0)  // showDiary가 nil일 경우 기본 처리
                cell.circleDateView.backgroundColor = .clear
            }
            
//            if let isEmpty = cell.dateLabel.text?.isEmpty {
//                if isEmpty {
//                    cell.circleDateView.backgroundColor = .clear
//                } else {
//                    cell.circleDateView.backgroundColor = .green
//                }
//            } else {
//                cell.circleDateView.backgroundColor = .clear
//            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 1, let day = Int(days[indexPath.row]) else { return }

        var selectedComponents = components
        selectedComponents.day = day
    
        let viewController = UIViewController.getViewController(viewControllerEnum: .dayRating)
        guard let dayRatingViewController = viewController as? DayRatingViewController else {
            navigationController?.pushViewController(viewController, animated: true)
            return
        }
        dayRatingViewController.selectedDate = calendar.date(from: selectedComponents)
        
        navigationController?.pushViewController(dayRatingViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadCalendarData()
        calendarCollectionView.reloadData()
    }

    func reloadCalendarData() {
        let realm = try! Realm()
        let diaries = realm.objects(Diary.self)
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: Int = Int(collectionView.bounds.width)
        return CGSize(width: width / 7, height: width / 7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
