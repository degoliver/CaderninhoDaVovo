//
//  MinhaReceitaTableViewCell.swift
//  CaderninhoDaVovo
//
//  Created by Diego on 01/12/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit

class MinhaReceitaTableViewCell: UITableViewCell {

    @IBOutlet weak var lblReceita: UILabel!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var imgReceita: UIImageView!
    @IBOutlet weak var loadImg: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func editReceita(sender: UIButton) {
    }
    
}
