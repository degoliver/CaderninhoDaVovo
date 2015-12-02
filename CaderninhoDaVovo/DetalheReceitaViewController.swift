//
//  detalheReceitaViewController.swift
//  CaderninhoDaVovo
//
//  Created by Diego on 29/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit
import Parse

class DetalheReceitaViewController: UIViewController, UIScrollViewDelegate {
    
    var codigo:String?
    var receita:Receita?
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var imgReceita: UIImageView!
    @IBOutlet weak var loadImg: UIActivityIndicatorView!
    @IBOutlet weak var lblNome: UILabel!
    @IBOutlet weak var lblUsuario: UILabel!
    @IBOutlet weak var scroolView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Receita.carregaReceita("http://syskf.institutobfh.com.br//modulos/appCaderninho/selectReceita.ashx?receitaID=" + codigo! + "&usuarioID="+PFUser.currentUser()!.objectId!, callback: carregaView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retornaImagem(img: UIImage?) {
        if(img != nil){
            self.loadImg.stopAnimating()
            self.imgReceita.image = img
        }
    }
    
    func carregaView(receitas:[Receita]){
        if(receitas.count==0){ return }
        receita = receitas[0]
        
        if(receita?.imagem != ""){
            loadImg.startAnimating()
            Utils.downloadImage((receita?.imagem)!, callback: retornaImagem)
        }
        
        lblUsuario.text = "Por: \(receita!.nomeUsuario!)"
        lblNome.text = receita?.nome
        
        imgLike.image = UIImage(named: (receita!.marcadolike!) ? "heart" : "heartWhite")
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        imgLike.userInteractionEnabled = true
        imgLike.addGestureRecognizer(tapGestureRecognizer)
        
        if(receita!.qtdLike! == 0){
            lblLike.text = "Ninguém favoritou esta receita ainda"
        }else {
            lblLike.text = "\(receita!.qtdLike!)" + ((receita!.qtdLike! > 1) ? " gostaram " : " gostou ") + "desta receita"
        }
        
        
        //Cria view INGREDIENTES
        let lblIng:UILabel = UILabel(frame: CGRectMake(10, 25, 288, 20))
        lblIng.text = receita!.ingredientes!
        lblIng.numberOfLines = 0
        lblIng.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lblIng.font = UIFont(name: ".SFUIText-Regular", size: 12)
        lblIng.sizeToFit()
        let view1:UIView = UIView(frame: CGRectMake(10,260,300,lblIng.frame.height+40))
        view1.backgroundColor = UIColor.yellowColor().colorWithAlphaComponent(0.2)
        view1.layer.cornerRadius = 9.0
        let label:UILabel = UILabel(frame: CGRectMake(5, 5, 288, 20))
        label.text = "-- INGREDIENTES --"
        label.font = UIFont(name: "Copperplate", size: 14)
        label.textAlignment = NSTextAlignment.Center
        view1.addSubview(label)
        view1.addSubview(lblIng)
        self.scroolView.addSubview(view1)
        
        //Cria view MODO DE PREPARO
        let lblModPre:UILabel = UILabel(frame: CGRectMake(10, 25, 288, 20))
        lblModPre.text = receita!.descricao!
        lblModPre.numberOfLines = 0
        lblModPre.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lblModPre.font = UIFont(name: ".SFUIText-Regular", size: 12)
        lblModPre.sizeToFit()
        let view2:UIView = UIView(frame: CGRectMake(10,270 + view1.frame.height,300,lblModPre.frame.height+40))
        view2.backgroundColor = UIColor.yellowColor().colorWithAlphaComponent(0.2)
        view2.layer.cornerRadius = 9.0
        let lbl:UILabel = UILabel(frame: CGRectMake(5, 5, 288, 20))
        lbl.text = "-- MODO DE PREPARO --"
        lbl.font = UIFont(name: "Copperplate", size: 14)
        lbl.textAlignment = NSTextAlignment.Center
        view2.addSubview(lbl)
        view2.addSubview(lblModPre)
        self.scroolView.addSubview(view2)
        
        scroolView.contentSize.height = 230 + view1.frame.height + view2.frame.height
    }
    
    func imageTapped(img: AnyObject)
    {
        
        
        if(receita!.marcadolike!){
            imgLike.image = UIImage(named: "heartWhite")
        }else{
            imgLike.image = UIImage(named: "heart")
        }
        receita?.marcadolike = !receita!.marcadolike!
    }
    
}
