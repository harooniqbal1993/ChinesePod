//
//  HomeCell.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 24/12/2023.
//

import UIKit

class HomeCell: UITableViewCell {
    
    enum ContentType {
        case Lesson
        case Course
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cellType: CellType? = nil
    var onTap: ((ContentType, LessonResponseModel) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "HomeLessonCell", bundle: nil), forCellWithReuseIdentifier: "HomeLessonCell")
        collectionView.register(UINib(nibName: "CourseCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CourseCollectionCell")
    }
    
    func configure(cellType: CellType) {
        self.cellType = cellType
    }
}

extension HomeCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if cellType == .Lessons {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeLessonCell", for: indexPath) as! HomeLessonCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseCollectionCell", for: indexPath) as! CourseCollectionCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onTap?(cellType == .Lessons ? .Lesson : .Course, LessonResponseModel())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if cellType == .Lessons {
            return CGSize(width: 180, height: 150)
        } else {
            return CGSize(width: 120, height: 160)
        }
    }
}
