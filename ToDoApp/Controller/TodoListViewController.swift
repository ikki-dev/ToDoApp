//
//  ViewController.swift
//  ToDoApp
//
//  Created by kobayashi ikki on 2019/04/07.
//  Copyright © 2019 Ikki. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let realmManager : RealmManager = RealmManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }
    
    //----------------------------------------//
    // TableView関連
    //----------------------------------------//
    
    //cellの個数の設定
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let taskDatas = realmManager.getTodoDataParams()
        return taskDatas.count
    }
    
    //生成するセルの設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let taskDatas = realmManager.getTodoDataParams()[indexPath.row] //object型を複数入れた配列を返し、index番号を関連づける
        cell.textLabel?.text = taskDatas.title
        
        //保存したフラグの情報をチェック
        if taskDatas.flag == true{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    //セルが選択された時の設定
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        let taskDatas = realmManager.getTodoDataParams()[indexPath.row]
        
        // チェックマークを入れる
        if taskDatas.flag == false{
            realmManager.changeFlagTrueTodoDataParams(taskDatas)
            cell?.accessoryType = .checkmark
        }else{
            realmManager.changeFlagFalseTodoDataParams(taskDatas)
            cell?.accessoryType = .none
        }
        self.tableView.reloadData() // リロードしてUIに反映
    }
    
    // アイテム削除処理
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let taskDatas = realmManager.getTodoDataParams()[indexPath.row]
        realmManager.deleteSingleTodoDataParams(taskDatas)
        tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.bottom)
        self.tableView.reloadData()
    }
    
    
    //----------------------------------------//
    // NavigationButton関連
    //----------------------------------------//
    
    // プラスボタンが押された時に実行される処理
    @IBAction func addButtonPressed(_ sender: Any) {
    
        var textField = UITextField()
        let alert = UIAlertController(title: "新しいタスクを追加", message: "", preferredStyle: .alert)
        
        // 「リストに追加」を押された時に実行される処理
        let addAction = UIAlertAction(title: "リストに追加", style: .default) { (action) in
            
            if !(textField.text == ""){
                //TodoDataParamsをインスタンス化
                let todoDataParams : TodoDataParams = TodoDataParams()
                // アイテム追加処理
                todoDataParams.title = textField.text!
                todoDataParams.flag = false
                
                //アイテムの保存
                self.realmManager.saveTodoDataParams( todoDataParams )
                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            
        }
        
        //textFieldの設定
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "新しいタスク"
            textField = alertTextField
        }
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    //ゴミ箱のボタンが押された時の処理
    @IBAction func trashButtonPressed(_ sender: Any) {
    
        let alert = UIAlertController(title: "全てのタスクを削除しますか？", message: "", preferredStyle: .alert)
        
        
        //削除する時の処理
        let deleteAction: UIAlertAction = UIAlertAction(title: "削除する", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            self.realmManager.deleteTodoDataParams()//全件削除
            self.tableView.reloadData()//テーブルビューを再読み込み
        })
        
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
        })
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
    
}

