//
//  WeekView.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/23.
//

import UIKit

class WeekView: UICollectionView {
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {

        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.minimumInteritemSpacing = 1
        flow.minimumLineSpacing = 2
        flow.sectionInset = .zero
        flow.itemSize = CGSize(width: UIScreen.main.bounds.width / 5, height: UIScreen.main.bounds.height)
        
        super.init(frame: frame, collectionViewLayout: flow)
        
        register(WeekDayColumnCell.self, forCellWithReuseIdentifier: WeekDayColumnCell.identifier)
        register(TimeIndexCellCollectionViewCell.self, forCellWithReuseIdentifier: TimeIndexCellCollectionViewCell.identifier)
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeekView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let timeIndexColumnWidth = 32.0
        let weekDaysWidth = UIScreen.main.bounds.width - timeIndexColumnWidth
        
        
        if indexPath.row == 0 {
            return CGSize(width: timeIndexColumnWidth, height: UIScreen.main.bounds.height)
        }
        return CGSize(width: weekDaysWidth / 5, height: UIScreen.main.bounds.height)
    }
}

extension WeekView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WeekDay.allCases.count + 1//(+ 1 = time Index)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeIndexCellCollectionViewCell.identifier, for: indexPath) as? TimeIndexCellCollectionViewCell
            else { return UICollectionViewCell() }
            return cell
        }
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekDayColumnCell.identifier, for: indexPath) as? WeekDayColumnCell
        else { return UICollectionViewCell() }
        cell.weekDay = WeekDay.allCases[indexPath.row - 1]
        return cell
    }
    
}
