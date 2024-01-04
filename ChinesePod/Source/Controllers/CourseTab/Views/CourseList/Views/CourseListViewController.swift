//
//  CourseListViewController.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 03/01/2024.
//

import UIKit

class CourseListViewController: UIViewController {

    @IBOutlet weak var courseTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    func configure() {
        courseTable.delegate = self
        courseTable.dataSource = self
        
        courseTable.register(UINib(nibName: "LessonCell", bundle: nil), forCellReuseIdentifier: "LessonCell")
    }
}

extension CourseListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell", for: indexPath) as! LessonCell
        return cell
    }
}
