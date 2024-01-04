//
//  LessonFilterViewController.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 27/12/2023.
//

import UIKit

class LessonFilterViewController: UIViewController {

    @IBOutlet weak var tabCollectionView: UICollectionView!
    @IBOutlet weak var pagingView: UIView!
    
    private var pageController: UIPageViewController?
    
    var isCourseVC: Bool? = false
    var lessonFilterViewModel: LessonFilterViewModel? = nil
    var viewControllers: [UIViewController] = []
    var selectedTab: Int = 0
    var currentPage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    func configure() {
        tabCollectionView.delegate = self
        tabCollectionView.dataSource = self
        
        tabCollectionView.register(UINib(nibName: "TopMenuCell", bundle: nil), forCellWithReuseIdentifier: "TopMenuCell")
        
        lessonFilterViewModel = LessonFilterViewModel()
        lessonFilterViewModel?.getOptions(isCourseVC: isCourseVC)
        
        if isCourseVC ?? false {
            viewControllers = [Constants.courseStoryboard.instantiateViewController(withIdentifier: "CourseDetailViewController") as! CourseDetailViewController,
                               Constants.courseStoryboard.instantiateViewController(withIdentifier: "CourseListViewController") as! CourseListViewController]
        } else {
            viewControllers = [Constants.lessonStoryboard.instantiateViewController(withIdentifier: "LessonDetailViewController") as! LessonDetailViewController,
                               Constants.lessonStoryboard.instantiateViewController(withIdentifier: "LessonDialogueViewController") as! LessonDialogueViewController,
                               Constants.lessonStoryboard.instantiateViewController(withIdentifier: "LessonDialogueViewController") as! LessonDialogueViewController,
                               Constants.lessonStoryboard.instantiateViewController(withIdentifier: "LessonDialogueViewController") as! LessonDialogueViewController,
                               Constants.lessonStoryboard.instantiateViewController(withIdentifier: "LessonDialogueViewController") as! LessonDialogueViewController]
        }
        
        setupPageController()
    }
    
    private func setupPageController() {
        
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
        self.pageController?.view.backgroundColor = .clear
//        self.pageController?.view.frame = pagingView.frame
        self.addChild(self.pageController!)
        self.pagingView.addSubview(self.pageController!.view)
        
        self.pageController?.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
        
        self.pageController?.didMove(toParent: self)
        
        self.pageController?.view.translatesAutoresizingMaskIntoConstraints = false
        self.pageController?.view.topAnchor.constraint(equalTo: pagingView!.topAnchor).isActive = true
        self.pageController?.view.bottomAnchor.constraint(equalTo: pagingView!.bottomAnchor).isActive = true
        self.pageController?.view.leadingAnchor.constraint(equalTo: pagingView!.leadingAnchor, constant: 0).isActive = true
        self.pageController?.view.trailingAnchor.constraint(equalTo: pagingView!.trailingAnchor, constant: 0).isActive = true
    }
}

extension LessonFilterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lessonFilterViewModel?.options.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopMenuCell", for: indexPath) as! TopMenuCell
        cell.configure(text: lessonFilterViewModel?.options[indexPath.item] ?? "")
        cell.configureViewModel(viewModel: TopMenuCellViewModel(isActive: indexPath.row == selectedTab))
//        currentPage = indexPath.item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let direction: UIPageViewController.NavigationDirection = indexPath.item > selectedTab ? .forward : .reverse
        selectedTab = indexPath.item
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        tabCollectionView.reloadData()
        pageController?.setViewControllers([viewControllers[indexPath.item]], direction: direction, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: LessonLevel.allCases[indexPath.item].toParamString().size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width + 25, height: 60)
        return CGSize(width: 50 + 25, height: 60)
    }
}

extension LessonFilterViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.lastIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex: Int = index - 1
        
        guard previousIndex >= 0 else { return nil}
        guard previousIndex < viewControllers.count else { return nil }
        currentPage = index - 1
        selectedTab = previousIndex
        return viewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.lastIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex: Int = index + 1
        
        guard previousIndex >= 0 else { return nil }
        guard previousIndex < viewControllers.count else { return nil }
        currentPage = index + 1
        selectedTab = previousIndex
        return viewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (completed && finished) {
            let viewController = (pageController?.viewControllers![0])!
            let index = viewControllers.firstIndex(of: viewController)
            selectedTab = index ?? 0
            tabCollectionView.scrollToItem(at: IndexPath(item: index ?? 0, section: 0), at: .centeredHorizontally, animated: true)
            tabCollectionView.reloadData()
        }
    }
}
