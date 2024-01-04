//
//  DialogueCell.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 01/01/2024.
//

import UIKit

class DialogueCell: UITableViewCell {

    @IBOutlet weak var audioView: UIView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var purpleView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var yellowView: UIView!
    
    var onTap: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadViews()
    }
    
    func loadViews() {
        audioView.isHidden = true
        menuView.isHidden = true
//        greenView.isHidden = true
    }
    
    func toggleViews() {
        if audioView.isHidden {
            audioView.isHidden = false
            menuView.isHidden = false
        } else {
            audioView.isHidden = true
            menuView.isHidden = true
        }
//        audioView.isHidden = !audioView.isHidden
//        menuView.isHidden = !menuView.isHidden
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        audioView.isHidden = !audioView.isHidden
        menuView.isHidden = !menuView.isHidden
        
//        greenView.isHidden = false
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
//        greenView.isHidden = true
//        onTap?()
    }
    
}
