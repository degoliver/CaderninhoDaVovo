//
//  BackgroundViewController.swift
//  CaderninoDaVovo
//
//  Created by Usuário Convidado on 25/11/15.
//  Copyright © 2015 Usuário Convidado. All rights reserved.
//

import UIKit

class BackgroundViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let fundo = UIImageView(image: UIImage(named: "batedeira"))
        fundo.sizeToFit()
        fundo.alpha = 0.7
        
        fundo.frame = CGRect(x: 0, y: 0, width: 320, height: 570)
            
        self.view.addSubview(fundo)
        self.view.sendSubviewToBack(fundo)
        
        let nome = UILabel()
        nome.text = "Caderninho da Vovó"
        nome.frame = CGRectMake(40, 50, 250, 40)
        nome.font = UIFont(name: "zapfino", size: 20)
        self.view.addSubview(nome)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
