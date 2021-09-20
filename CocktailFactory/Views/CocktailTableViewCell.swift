//
//  CocktailTableViewCell.swift
//  CocktailFactory
//
//  Created by David Todua on 06.09.21.
//

import UIKit

class CocktailTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var cocktailNameLabel: UILabel!
    
    @IBOutlet weak var alcoholicLabel: UILabel!
    
    var onReuse: ()-> Void = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
//
//        layer.cornerRadius = 15
//        layer.masksToBounds = true
        backgroundColor = UIColor(named: "First")
        contentView.backgroundColor = UIColor(named: "Second")

        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
//       contentView.backgroundColor = UIColor(named: "Second")
//        self.alcoholicLabel.backgroundColor = .clear
//        self.categoryLabel.
    }
    
//    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        onReuse()
        avatarImage.image = nil
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
