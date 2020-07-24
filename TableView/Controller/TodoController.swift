//
//  TodoController.swift
//  TableView
//
//  Created by 刘皇逊 on 4/11/19.
//  Copyright © 2019 刘皇逊. All rights reserved.
//

import UIKit

protocol TodoDelegate {
    func didAdd(name:String)
    func didEdit(name:String)
}
class TodoController: UITableViewController {
    
    var delegate:TodoDelegate?
    var name:String?

    @IBOutlet weak var todoinput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        todoinput.becomeFirstResponder()
        todoinput.text = name
        if name != nil{
            navigationItem.title = "编辑任务"
        }
    }
    
    
    
    @IBAction func done(_ sender: Any) {
        if let name = todoinput.text, !name.isEmpty{
            if self.name != nil{
                delegate?.didEdit(name: name)
            }else{
             delegate?.didAdd(name: name)
        }
        }
       navigationController?.popViewController(animated: true)
        
    }
    
   
//    @IBAction func done(_ sender: Any) {
//        //todoinput.text
//        if let name = todoinput.text, !name.isEmpty{
//             delegate?.didAdd(name: name)
//        }
//        navigationController?.popViewController(animated: true)
//
//     }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
