//
//  CourseViewController.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 03/01/2024.
//

import UIKit

class CourseViewController: UIViewController {

    @IBOutlet weak var tabCollectionView: UICollectionView!
    @IBOutlet weak var baseCollectionView: UICollectionView!
    
    var lessonViewModel: LessonViewModel! = nil
    var selectedTab: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    func configure() {
        lessonViewModel = LessonViewModel()
        
        tabCollectionView.delegate = self
        tabCollectionView.dataSource = self
        
        baseCollectionView.dataSource = self
        baseCollectionView.delegate = self
        baseCollectionView.isPagingEnabled = true
        
        tabCollectionView.register(UINib(nibName: "TopMenuCell", bundle: nil), forCellWithReuseIdentifier: "TopMenuCell")
        baseCollectionView.register(UINib(nibName: "CoursePageCell", bundle: nil), forCellWithReuseIdentifier: "CoursePageCell")
        
    }
}

extension CourseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LessonLevel.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopMenuCell", for: indexPath) as! TopMenuCell
            cell.configure(text: LessonLevel.allCases[indexPath.row].toParamString())
            
            cell.configureViewModel(viewModel: TopMenuCellViewModel(isActive: indexPath.row == selectedTab))
//            cell.topMenuCellViewModel?.isActive = indexPath.row == 2
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoursePageCell", for: indexPath) as! CoursePageCell
//            cell.configure(viewModel: PageCellViewModel(lessons: (lessonViewModel?.filterLessons(lessonLevel: LessonLevel.allCases[indexPath.row]))!))
            cell.label.text = LessonLevel.allCases[indexPath.row].toParamString()
            baseCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            selectedTab = indexPath.item
            tabCollectionView.reloadData()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tabCollectionView {
//            return CGSize(width: 150, height: 60)
            return CGSize(width: LessonLevel.allCases[indexPath.item].toParamString().size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width + 25, height: 60)
            
        } else {
            print("Frame : ", collectionView.frame.width, collectionView.frame.height)
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTab = indexPath.item
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        baseCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        tabCollectionView.reloadData()
    }
}
