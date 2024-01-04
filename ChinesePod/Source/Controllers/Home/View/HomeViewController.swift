//
//  HomeViewController.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 23/12/2023.
//

import UIKit

enum CellType: Int {
    case Banner = 0
    case Cards = 1
    case QuickTags = 2
    case Lessons = 3
    case Courses = 4
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var homeViewModel: HomeViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        homeViewModel = HomeViewModel()
        homeViewModel?.getLessons()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "BannerCell", bundle: nil), forCellReuseIdentifier: "BannerCell")
        tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        tableView.register(UINib(nibName: "QuickTagCell", bundle: nil), forCellReuseIdentifier: "QuickTagCell")
        tableView.register(UINib(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: "CardCell")
        
    }
    
    private func switchTab(type: CardCell.CardType) {
        switch type {
        case .Lessons:
            tabBarController?.selectedIndex = 1
            break
        case .Courses:
            tabBarController?.selectedIndex = 2
            break
        case .Flashcards:
//            tabBarController?.selectedIndex = 1
            break
        default:
            tabBarController?.selectedIndex = 1
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == CellType.Banner.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCell", for: indexPath) as! BannerCell
            return cell
        } else if indexPath.row == CellType.Cards.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardCell
            cell.onTapped = { [weak self] cardType in
                self?.switchTab(type: cardType)
            }
            return cell
        } else if indexPath.row == CellType.Lessons.rawValue || indexPath.row == CellType.Courses.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
            cell.configure(cellType: CellType(rawValue: indexPath.row) ?? .Lessons)
            cell.onTap = { [weak self] contentType, lesson in
//                let detailVC = Constants.lessonStoryboard.instantiateViewController(withIdentifier: "LessonDetailViewController") as! LessonDetailViewController
//                let detailVC = Constants.lessonStoryboard.instantiateViewController(withIdentifier: "LessonDialogueViewController") as! LessonDialogueViewController
                let detailVC = Constants.lessonStoryboard.instantiateViewController(withIdentifier: "LessonFilterViewController") as! LessonFilterViewController
                detailVC.isCourseVC = contentType == .Course ? true : false
                self?.navigationController?.pushViewController(detailVC, animated: true)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuickTagCell", for: indexPath) as! QuickTagCell
            cell.onTapped = { [weak self] tag in
                print(tag)
            }
            return cell
        }
    }
}
