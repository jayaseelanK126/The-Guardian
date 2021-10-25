//
//  NewsListTableViewCell.swift
//  The Guardian
//
//  Created by Pyramid on 23/10/21.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {

    @IBOutlet weak var outerView: UIView!
    
    @IBOutlet weak var newsTitleLbl: UILabel!
    
    @IBOutlet weak var newsThumbnailImg: UIImageView!
    
    @IBOutlet weak var bodyLbl: UILabel!
    
    @IBOutlet weak var publicationDateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setDesignStyle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDesignStyle()
    {
        CSS.customLabel(newsTitleLbl, textColor: .black)
        CSS.customLabel(bodyLbl, textColor: .gray)
        CSS.customLabel(publicationDateLbl, textColor: .lightGray)
        CSS.customCardView(outerView)
        newsThumbnailImg.makeRounded(cornerRadius: 15.0)
    }
}
