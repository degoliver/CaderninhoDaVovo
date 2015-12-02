//
//  MinhasReceitasTableViewController.swift
//  CaderninhoDaVovo
//
//  Created by Diego on 01/12/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit
import Parse

class MinhasReceitasTableViewController: UITableViewController {

    var receitas:[Receita] = [Receita]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Receita.carregaReceita("http://syskf.institutobfh.com.br//modulos/appCaderninho/selectReceitaList.ashx?usuarioID="+PFUser.currentUser()!.objectId!, callback: carregaTable)
    }
    
    func carregaTable(receitas:[Receita]){
        self.receitas = receitas
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return receitas.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID", forIndexPath: indexPath) as! MinhaReceitaTableViewCell
        
        cell.lblReceita.text = self.receitas[indexPath.row].nome
        cell.lblLike.text = (self.receitas[indexPath.row].qtdLike! == 0) ? "Ninguém favoritou ainda" : String(self.receitas[indexPath.row].qtdLike!) + ((self.receitas[indexPath.row].qtdLike! == 1) ? " gostou" : " gostaram")
        if(self.receitas[indexPath.row].imagem != ""){
            cell.loadImg.startAnimating()
            Utils.downloadImage(self.receitas[indexPath.row].imagem!, callback: retornaImagem, sender: cell)
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("minhaReceitaToDetalheSegue", sender: self.receitas[indexPath.row].codigo)
    }
    
    @IBAction func adicionarReceita(sender: UIBarButtonItem) {
    }
    
    @IBAction func LogoutAction(sender: UIBarButtonItem) {
        PFUser.logOut()
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func retornaImagem(img: UIImage?, sender: AnyObject?){
        let cell = sender as? MinhaReceitaTableViewCell
        if(img != nil){
            cell?.imgReceita.image = img
        }
        cell?.loadImg.stopAnimating()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="minhaReceitaToDetalheSegue"){
            let vc:DetalheReceitaViewController = segue.destinationViewController as!DetalheReceitaViewController
            vc.codigo = "\(sender!)"
        }
        if(segue.identifier=="minhaReceitaToEditarSegue"){
            let vc:EditarReceitasViewController = segue.destinationViewController as!EditarReceitasViewController
            vc.codigo = "\(sender!)"
        }
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

}
