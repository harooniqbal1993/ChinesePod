//
//  CourseDetailViewController.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 03/01/2024.
//

import UIKit

class CourseDetailViewController: UIViewController {

    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var courseLevel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func bookmarkButtonTapped(_ sender: UIButton) {
    }
}
