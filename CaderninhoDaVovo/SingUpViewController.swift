//
//  SingUpViewController.swift
//  CaderninoDaVovo
//
//  Created by Usuário Convidado on 25/11/15.
//  Copyright © 2015 Usuário Convidado. All rights reserved.
//

import UIKit
import Parse

class SingUpViewController: BackgroundViewController {
   
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var signup_btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signup_btn.backgroundColor = UIColor.clearColor()
        signup_btn.layer.cornerRadius = 5
        signup_btn.layer.borderWidth = 2
        signup_btn.layer.borderColor = UIColor.blackColor().CGColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func SingUpAction(sender: UIButton) {
        let name = self.nameField.text
        let username = self.usernameField.text
        let password = self.passwordField.text
        let email = self.emailField.text
        
        if(name?.utf16.count < 3){
            let alert = UIAlertView(title: "Erro", message: "Nome Inválido", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        if(username?.utf16.count < 4 || password?.utf16.count < 5){
            let alert = UIAlertView(title: "Erro", message: "Usuário ou Senha Inválida", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }else if(email?.utf16.count < 8){
            let alert = UIAlertView(title: "Erro", message: "Email Inválido", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }else{
            let newUser = PFUser()
            newUser.username = username
            newUser.password = password
            newUser.email = email
            newUser["nome"] = name
            
            newUser.signUpInBackgroundWithBlock({ (sucess, error ) -> Void in
                
                if((error) != nil){
                    let alert = UIAlertView(title: "Erro", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }else{
                    let alert = UIAlertView(title: "Sucesso", message: "Usuário Criado", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    self.dismissViewControllerAnimated(false, completion: nil)
                    
                    self.salvaUsuario()
                    
                }
            })
        }
    }
    
    func salvaUsuario(){
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let nsurl = NSURL(string: "http://syskf.institutobfh.com.br//modulos/appCaderninho/saveUsuario.ashx")!
        let request = NSMutableURLRequest(URL: nsurl)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        var paramString = "login=\(PFUser.currentUser()!.username!)"
        paramString += "&senha=\(PFUser.currentUser()!.password!)"
        paramString += "&nome=\(PFUser.currentUser()!["nome"]!)"
        paramString += "&email=\(PFUser.currentUser()!.email!)"
        paramString += "&codigo=\(PFUser.currentUser()!.objectId!)"
        
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            
            let retStr: String = String(data: data!, encoding: NSUTF8StringEncoding)!
            print(retStr)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.resultado(data)
            })
        })
        task.resume()
    }
    
    func resultado(data:NSData?) {
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
            if let result = json["msg"] as? String {
                print(result)
            }
        }catch{
            print("ERRO")
        }
    }
}
