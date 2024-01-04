//
//  QuickTagCell.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 25/12/2023.
//

import UIKit

class QuickTagCell: UITableViewCell {
    
    enum TagType {
        case bookmarked
        case studied
        case downloaded
    }

    @IBOutlet weak var bookedmarkedButton: UIButton!
    @IBOutlet weak var studiedButton: UIButton!
    @IBOutlet weak var downloadedButton: UIButton!
    
    var onTapped: ((TagType) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadViews()
    }
    
    private func loadViews() {
        bookedmarkedButton.border(color: .red, radius: 10.0, width: 1.0)
        studiedButton.border(color: .red, radius: 10.0, width: 1.0)
        downloadedButton.border(color: .red, radius: 10.0, width: 1.0)
    }
    
    @IBAction func bookmarkedTapped(_ sender: UIButton) {
        onTapped?(.bookmarked)
    }
    
    @IBAction func studiedTapped(_ sender: UIButton) {
        onTapped?(.studied)
    }
    
    @IBAction func downloadedTapped(_ sender: UIButton) {
        onTapped?(.downloaded)
    }
}
