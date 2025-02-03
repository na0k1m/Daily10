//
//  CalendarViewController.swift
//  Daily10
//
//  Created by 김나영 on 1/30/25.
//

import UIKit

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    private let temp: [Int] = [1, 2, 3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarCollectionView.register(UINib(nibName: String(describing: DateCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: DateCollectionViewCell.self))
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
    }
}

extension CalendarViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return temp.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DateCollectionViewCell
        if let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DateCollectionViewCell.self), for: indexPath) as? DateCollectionViewCell {
            cell = reusableCell
        } else {
            let objectArray = Bundle.main.loadNibNamed(String(describing: DateCollectionViewCell.self), owner: nil, options: nil)
            cell = objectArray![0] as! DateCollectionViewCell
        }
        
        cell.mainLabel.text = "\(temp[indexPath.row])"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
