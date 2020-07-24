//
//  TodosController.swift
//  TableView
//
//  Created by 刘皇逊 on 4/11/19.
//  Copyright © 2019 刘皇逊. All rights reserved.
//

import UIKit

class TodosController: UITableViewController {
    
    var todos:[Todo] = [
        Todo(name: "code", checked: false),
        Todo(name: "PS4", checked: false),
        Todo(name: "switch", checked: false),
        Todo(name: "PC", checked: false)
        
    ]
    //定义空数组
    //var dic:[String:String] = [:]
    //var dic = [String:String]()
    var row = 0

    @IBAction func batchDelete(_ sender: Any) {
        if let indexPaths = tableView.indexPathsForSelectedRows{
            for indexPath in indexPaths {
                
                todos.remove(at: indexPath.row)
               }
            tableView.beginUpdates()
            tableView.deleteRows(at: indexPaths, with: .automatic)
            tableView.endUpdates()
        }
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        editButtonItem.title = "编辑"
        if let data = UserDefaults.standard.data(forKey: "todos"){
            do{
                 todos = try JSONDecoder().decode([Todo].self, from: data)
            }catch{
                print(error)
            }
           
        }
        
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        editButtonItem.title = isEditing ? "完成" : "编辑"
    }
 
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath) as! TodoCell
        
//        indexPath.row
//        indexPath.section
        
        cell.checkMark.text = todos[indexPath.row].checked ? "√" : ""
        cell.todo.text = todos[indexPath.row].name

        // Configure the cell...
        //cell.textLabel?.text = "Something"
        return cell
    }
    
    //didselect
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //取反
        if !isEditing{
            todos[indexPath.row].checked = !todos[indexPath.row].checked
            saveDate()
            let cell = tableView.cellForRow(at: indexPath) as! TodoCell
            cell.checkMark.text = todos[indexPath.row].checked ? "√" : ""
            //取消cell状态，去底色
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //1.删除数据
            todos.remove(at: indexPath.row)
            // Delete the row from the data source--更新视图
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        //1.移动数据
//        var arr = [1,2,3,4]
//        arr.remove(at:0)
//        arr.insert(1,at:3)
        let todo = todos[fromIndexPath.row]
        todos.remove(at: fromIndexPath.row)
        todos.insert(todo, at: to.row)
        //2.更新视图
        //tableView.moveRow(at: fromIndexPath, to: to)
        tableView.reloadData()
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addTodo"{
            let vc = segue.destination as! TodoController
            //告诉我们干活的老板是谁
            vc.delegate = self
        }else if segue.identifier == "editTodo"{
            let vc = segue.destination as! TodoController
            let cell = sender as! TodoCell
            //通过cell找indexpath（上面的didselect方法是反的，共同点是都写上tableView.你需要的东西）
            row = tableView.indexPath(for: cell)!.row
            vc.name = todos[row].name
            vc.delegate = self
        }
    }
    

}

//遵守协议
extension TodosController:TodoDelegate{
    //实现协议里的方法
    func didAdd(name: String) {
        todos.append(Todo(name: name, checked: false))
        //数据存储到本地
        //UserDefaults.standard.set(todos, forKey: "todos")
        saveDate()
        let indexPath =  IndexPath(row: todos.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
    }
    func didEdit(name: String) {
        todos[row].name = name
        //数据存储到本地
       // UserDefaults.standard.set(todos, forKey: "todos")
        saveDate()
        let indexPath = IndexPath(row: row, section: 0)
        //通过indexpath找cell，继而找到里面的文本label，然后改text
        let cell = tableView.cellForRow(at: indexPath) as! TodoCell
        cell.todo.text = name
    }
    
    func saveDate(){
        do{
           let data = try JSONEncoder().encode(todos)
            UserDefaults.standard.set(data,forKey: "todos")
        }catch{
            print(error)
        }
        
    }
}
