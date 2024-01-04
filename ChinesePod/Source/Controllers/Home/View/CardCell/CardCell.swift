//
//  CardCell.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 26/12/2023.
//

import UIKit

class CardCell: UITableViewCell {
    
    enum CardType {
        case Lessons
        case Courses
        case Flashcards
        case Dictionary
    }

    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var iceBlueView: UIView!
    @IBOutlet weak var skyBlueView: UIView!
    
    var onTapped: ((CardType) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadViews()
    }
    
    private func loadViews() {
        redView.round(radius: 5.0)
        orangeView.round(radius: 5.0)
        iceBlueView.round(radius: 5.0)
        skyBlueView.round(radius: 5.0)
    }
    
    @IBAction func lessonsButtonTapped(_ sender: UIButton) {
        onTapped?(.Lessons)
    }
    
    @IBAction func playlistButtonTapped(_ sender: UIButton) {
        onTapped?(.Courses)
    }
    
    @IBAction func flashcardButtonTapped(_ sender: UIButton) {
        onTapped?(.Flashcards)
    }
    
    @IBAction func dictionaryButtonTapped(_ sender: UIButton) {
        onTapped?(.Dictionary)
    }
}
