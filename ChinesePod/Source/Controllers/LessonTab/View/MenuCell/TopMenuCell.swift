//
//  TopMenuCell.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 28/12/2023.
//

import UIKit

class TopMenuCell: UICollectionViewCell {

    @IBOutlet weak var menuText: UILabel!
    @IBOutlet weak var activeIndicator: UIView!
    
    var topMenuCellViewModel: TopMenuCellViewModel? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(text: String) {
        menuText.text = text
    }
    
    func configureViewModel(viewModel: TopMenuCellViewModel) {
        topMenuCellViewModel = viewModel
        activeIndicator.isHidden = !(topMenuCellViewModel?.isActive ?? false)
    }
}
