//
//  MenuTableViewCell.swift
//  TesterApp
//
//  Created by Joseph Chung on 4/23/21.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    private let PADDING: CGFloat = 10
    
    var iconImageView = UIImageView()
    var menuTitleLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    public override func layoutSubviews() {
        
        iconImageView.frame = CGRect(x: PADDING, y: (self.bounds.height / 2) - 15, width: 30, height: 30)
        iconImageView.layer.cornerRadius = iconImageView.bounds.height / 2
        iconImageView.backgroundColor = .white
        self.addSubview(iconImageView)
        
        menuTitleLabel.frame = CGRect(x: iconImageView.frame.maxX + PADDING, y: (self.bounds.height / 2) - 15, width: 200, height: 30)
        menuTitleLabel.textColor = .white
        menuTitleLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(menuTitleLabel)
        
    }

}
