//
//  fristviewCell.swift
//  Book
//
//  Created by Manish on 09/10/15.
//  Copyright (c) 2015 ifconit. All rights reserved.
//

import UIKit

class FristviewCell: UITableViewCell {

    @IBOutlet var shd: UIView!
    
    @IBOutlet var bknmm: UILabel!
    
    
    
    @IBOutlet var authornm: UILabel!
   
    @IBOutlet var bki: UIImageView!

    @IBOutlet var rek: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    
        
        //rek.layer.frame =
        shd.layer.shadowColor = UIColor.blackColor().CGColor
        shd.layer.shadowOffset = CGSize(width: 0, height: 2)
        shd.layer.shadowOpacity = 0.4
        shd.layer.shadowRadius = 5
        
        rek.layer.shadowColor = UIColor.blackColor().CGColor
        rek.layer.shadowOffset = CGSize(width: 0, height: 5)
        rek.layer.shadowOpacity = 0.4
        rek.layer.shadowRadius = 5
        rek.layer.cornerRadius = 1
        
        if bki.image != UIImage(named: "") {
            
            
            
        }else{
            bki.image = UIImage(named: "Noimg_icon")
            
        }


            }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
