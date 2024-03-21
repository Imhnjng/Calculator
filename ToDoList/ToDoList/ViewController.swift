//
//  ViewController.swift
//  ToDoList
//
//  Created by IMHYEONJEONG on 3/19/24.
//

import UIKit

class ViewController: UIViewController {
    var list = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.setEditing(true, animated: true)
        
    }

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addButton(_ sender: Any) {
        let alert = UIAlertController(title: "할 일 추가", message:"할 일을 입력해주세요.", preferredStyle: .alert)
        let addToDoList = UIAlertAction(title: "추가", style: .destructive, handler: { [weak self] _ in
            print("추가 버튼 눌렀음")
            guard let text = alert.textFields?[0].text else { return }
            self?.addToDoItem(title: text)
            
            // delete
//            self?.list.remove(at: 1)
//            self?.tableView.reloadData()
            
            // edit
//            self?.list[0].title = "1111"
//            self?.tableView.reloadData()
        })
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { _ in
            print("취소됨")
        }
        
        alert.addAction(addToDoList)
        alert.addAction(cancel)
        alert.addTextField { (myTextField) in
            myTextField.placeholder = "할 일을 적으세요"
        }

        self.present(alert, animated: true) { print( "alert 창 켜짐" )} //alert 창 띄워주는 코드
    }
        
    func addToDoItem(title: String) {
        self.list.append(Task(title: title, done: false))
        self.tableView.reloadData() //추가한 리스트를 보여줌
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection", section)
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) //셀 재사용
        
        let task = list[indexPath.row] //list 섹션의 행
        print([indexPath]) //[[0, 0]]
        print([indexPath.row]) //[0]
        cell.textLabel?.text = task.title
        
        let mySwitch = UISwitch()
        mySwitch.addTarget(self, action: #selector(didChangeSwitch(_ :)), for: .valueChanged)
        cell.accessoryView = mySwitch
//        if task.done {
//            cell.accessoryType = .checkmark
//        }
//        else {
//            cell.accessoryType = .none
//        }
        
        
        return cell
    }
    
    @objc func didChangeSwitch(_ sender: UISwitch) {
        if sender.isOn {
            print(" 완료 ! ")
        }
        else {
            print(" 해야지,, ")
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}


extension ViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        .delete
//    }
//    
//    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//    }
//    
//    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
//        print(indexPath?.row)
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var task = list[indexPath.row]
//        task.done = !task.done
//        tableView.reloadData()
//    }
    
}
