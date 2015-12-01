//
//  ReceitaTableViewCell.swift
//  CaderninoDaVovo
//
//  Created by Usuário Convidado on 25/11/15.
//  Copyright © 2015 Usuário Convidado. All rights reserved.
//

import UIKit

class ReceitaTableViewCell: UITableViewCell {

    @IBOutlet weak var lblReceita: UILabel!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var imgReceita: UIImageView!
    @IBOutlet weak var loadImg: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
