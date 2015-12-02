//
//  Utils.swift
//  CaderninhoDaVovo
//
//  Created by Diego on 02/12/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit

class Utils: UIViewController {

    class func salvaDados(url: String, params: [String]){
        salvaDados(url, params: params, alerta: false, callback: nil)
    }
    
    class func salvaDados(url: String, params: [String], alerta: Bool, callback: ((String) -> Void)?){
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let nsurl = NSURL(string: url)!
        let request = NSMutableURLRequest(URL: nsurl)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        var paramString = ""
        for(var a:Int = 0 ; a < params.count ; a++) {
            paramString += ((a > 0) ? "&" : "") + params[a]
        }
        
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            
            let retStr: String = String(data: data!, encoding: NSUTF8StringEncoding)!
            print(retStr)
            
            dispatch_async(dispatch_get_main_queue(), {
                let result = resultado(data, alerta: alerta)
                callback?(result)
            })
        })
        task.resume()
    }
    
    class func resultado(data:NSData?, alerta: Bool) -> String {
        var status: String = ""
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
            if let result = json["msg"] as? String {
                print(result)
                status = ((json["status"] as! String == "OK") ? "Sucesso" : "Erro")
                if(alerta){ alert(status, msg: result) }
            }
        }catch{
            print("ERRO")
            return "Erro"
        }
        return status
    }
    
    class func alert(title:String, msg:String){
        let actionAlert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        actionAlert.addAction(UIAlertAction(title: "OK", style:.Default, handler: nil))
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(actionAlert, animated: true, completion: nil)
    }
    
    class func downloadImage(imgURL: String, callback: (UIImage?) -> Void) {
        let url = NSURL(string: imgURL)!
        let imageSession = NSURLSession.sharedSession()
        let imgTask = imageSession.downloadTaskWithURL(url){(url,response,error) -> Void in
            if(error==nil){
                if let imageData = NSData(contentsOfURL: url!){
                    dispatch_async(dispatch_get_main_queue(), {
                        callback(UIImage(data: imageData))
                    })
                }
            } else{
                print("erro na imagem")
                callback(nil)
            }
        }
        imgTask.resume()
    }
    
    class func downloadImage(imgURL: String, callback: (UIImage?, sender: AnyObject?) -> Void, sender: AnyObject?) {
        let url = NSURL(string: imgURL)!
        let imageSession = NSURLSession.sharedSession()
        let imgTask = imageSession.downloadTaskWithURL(url){(url,response,error) -> Void in
            if(error==nil){
                if let imageData = NSData(contentsOfURL: url!){
                    dispatch_async(dispatch_get_main_queue(), {
                            callback(UIImage(data: imageData), sender: sender)
                    })
                }
            } else{
                print("erro na imagem")
                callback(nil, sender: sender)
            }
        }
        imgTask.resume()
    }
    
}
