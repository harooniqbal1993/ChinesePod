//
//  PageCell.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 28/12/2023.
//

import UIKit

class PageCell: UICollectionViewCell {

    @IBOutlet weak var tableView: UITableView!
    
    var pageCellViewModel: PageCellViewModel? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureTable()
    }

    func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "LessonCell", bundle: nil), forCellReuseIdentifier: "LessonCell")
    }
    
    func configure(viewModel: PageCellViewModel) {
        pageCellViewModel = viewModel
    }
}

extension PageCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell", for: indexPath) as! LessonCell
        return cell
    }
}
