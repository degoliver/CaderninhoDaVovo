//
//  CadastrarReceitasViewController.swift
//  CaderninhoDaVovo
//
//  Created by Usuário Convidado on 02/12/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit
import MobileCoreServices

class CadastrarReceitasViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
var imagePicker: UIImagePickerController!
    
    
    @IBOutlet weak var nomeReceita: UITextField!
    @IBOutlet weak var fotoexist: UIButton!
    @IBOutlet weak var cancelar: UIBarButtonItem!
    @IBOutlet weak var salvar: UIBarButtonItem!
    @IBOutlet weak var modeDePreparo: UITextView!
    @IBOutlet weak var ingrdientes: UITextView!
    @IBOutlet weak var tirarfoto: UIButton!
    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
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
  
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
      let img:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.img.image = img
        dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }


}
