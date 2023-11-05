//
//  CellTableViewCell.swift
//  TravelApp
//
//  Created by Jad ghoson on 28/10/2023.
//

import UIKit

class CellTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var boxTableView: UIView!
    
    @IBOutlet weak var containerImageView: UIImageView!
    
    @IBOutlet weak var reviewsLabel: UILabel!
    
    @IBOutlet weak var wishlistButton: UIButton!
    var wishListSelected = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        containerImageView.layer.cornerRadius = containerImageView.frame.size.height / 6
        boxTableView.layer.cornerRadius = boxTableView.frame.size.height / 6
        
        
    
        wishlistButton.layer.cornerRadius = wishlistButton.frame.size.height / 2.0
        wishlistButton.clipsToBounds = true
        
        reviewsLabel.layer.cornerRadius = reviewsLabel.bounds.width / 7.5
        reviewsLabel.clipsToBounds = true
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func whishListButton(_ sender: UIButton) {
        wishListSelected.toggle()
        let image = wishListSelected ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"); sender.setImage(image, for: .normal)
   
        print("done")
    }
    
}
