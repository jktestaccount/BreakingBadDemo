//
//  TableViewCell.swift
//  BreakingBadDemo
//
//  Created by Juan Kruger
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak private var characterImageView: UIImageView!
    @IBOutlet weak private var characterLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        characterImageView.layer.cornerRadius = 2
    }

    public func update(_ characterViewModel: CharacterViewModel) {
        
        characterLabel.text = characterViewModel.name.value
        
        if let imageURL = URL(string: characterViewModel.imageURLString.value) {

            characterImageView.sd_setImage(with: imageURL, completed: nil)
        }
        else {

            characterImageView.image = nil
        }
    }
}
