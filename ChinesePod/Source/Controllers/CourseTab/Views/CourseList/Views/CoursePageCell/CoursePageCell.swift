//
//  CoursePageCell.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 03/01/2024.
//

import UIKit

class CoursePageCell: UICollectionViewCell {

    @IBOutlet weak var courseCollectionView: UICollectionView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configure() {
        courseCollectionView.delegate = self
        courseCollectionView.dataSource = self
        
        courseCollectionView.register(UINib(nibName: "CourseCell", bundle: nil), forCellWithReuseIdentifier: "CourseCell")
    }
}

extension CoursePageCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseCell", for: indexPath) as! CourseCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (bounds.width / 2) - 0, height: (bounds.width / 2) - 0)
    }
}
