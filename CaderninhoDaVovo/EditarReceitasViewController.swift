//
//  EditarReceitasViewController.swift
//  CaderninhoDaVovo
//
//  Created by Usuário Convidado on 02/12/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit
import MobileCoreServices
import Parse

class EditarReceitasViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    var codigo:String?
    var receita:Receita?
    var imagePicker: UIImagePickerController!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var NomeReceita: UITextField!
    @IBOutlet weak var fotoexist: UIButton!
    @IBOutlet weak var cancelar: UIBarButtonItem!
    @IBOutlet weak var salvar: UIBarButtonItem!
    @IBOutlet weak var modeDePreparo: UITextView!
    @IBOutlet weak var ingrdientes: UITextView!
    @IBOutlet weak var tirarfoto: UIButton!
    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
   

       // Receita.carregaReceita("http://syskf.institutobfh.com.br//modulos/appCaderninho/selectReceita.ashx?receitaID=" + codigo!, callback: carregaView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancelar(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    
    @IBAction func tirarfoto(sender: AnyObject) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    @IBAction func fotoExitente(sender: AnyObject) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func salvarReceita(sender: AnyObject) {
        var ingre = ingrdientes.text
        var modo = modeDePreparo.text
        var imgem = img.image
        print(ingre)
        print(modo)
        //print(imagem.size)
        
    }
    func retornaImagem(img: UIImage?) {
        if(img != nil){
           // self.loadImg.stopAnimating()
            self.img.image = img
        }
    }
    func carregaView(receitas:[Receita]){
        if(receitas.count==0){ return }
        receita = receitas[0]
        
        if(receita?.imagem != ""){
            //loadImg.startAnimating()
            Utils.downloadImage((receita?.imagem)!, callback: retornaImagem)
        }
        NomeReceita.text = receita?.nome
        ingrdientes.text = receita!.ingredientes!
        modeDePreparo.text = receita!.descricao!
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let img:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.img.image = img
        dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

}
