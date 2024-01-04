//
//  LessonViewController.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 26/12/2023.
//

import UIKit

class LessonViewController: UIViewController {
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var pageCollectionView: UICollectionView!
    
    var lessonViewModel: LessonViewModel? = nil
    var selectedTab: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    func configure() {
        lessonViewModel = LessonViewModel()
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        
        pageCollectionView.isPagingEnabled = true
        
        menuCollectionView.register(UINib(nibName: "TopMenuCell", bundle: nil), forCellWithReuseIdentifier: "TopMenuCell")
        pageCollectionView.register(UINib(nibName: "PageCell", bundle: nil), forCellWithReuseIdentifier: "PageCell")
    }
}

extension LessonViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LessonLevel.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == menuCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopMenuCell", for: indexPath) as! TopMenuCell
            cell.configure(text: LessonLevel.allCases[indexPath.row].toParamString())
            
            cell.configureViewModel(viewModel: TopMenuCellViewModel(isActive: indexPath.row == selectedTab))
//            cell.topMenuCellViewModel?.isActive = indexPath.row == 2
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCell", for: indexPath) as! PageCell
            cell.configure(viewModel: PageCellViewModel(lessons: (lessonViewModel?.filterLessons(lessonLevel: LessonLevel.allCases[indexPath.row]))!))
            menuCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            selectedTab = indexPath.item
            menuCollectionView.reloadData()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == menuCollectionView {
//            return CGSize(width: 150, height: 60)
            return CGSize(width: LessonLevel.allCases[indexPath.item].toParamString().size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width + 25, height: 60)
            
        } else {
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == menuCollectionView {
//            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        }
        selectedTab = indexPath.item
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        menuCollectionView.reloadData()
    }
}
