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
    

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func SingUpAction(sender: UIButton) {
        let username = self.usernameField.text
        let password = self.passwordField.text
        let email = self.emailField.text
        
        if(username?.utf16.count < 4 || password?.utf16.count < 5){
            
            let alert = UIAlertView(title: "Invalid", message: "Usuario ou Senha Invalida ", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }else if(email?.utf16.count < 8){
            let alert = UIAlertView(title: "Invalid", message: "Email Invalido", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }else{
            
            let newUser = PFUser()
            newUser.username = username
            newUser.password = password
            newUser.email = email
            
            newUser.signUpInBackgroundWithBlock({ (sucess, error ) -> Void in
                
                if((error) != nil){
                    let alert = UIAlertView(title: "Invalid", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }else{
                    let alert = UIAlertView(title: "Success", message: "Usuario Criado", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    self.dismissViewControllerAnimated(false, completion: nil)
                }
            })
            
        }
        
    }
}
