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
        
//        for i in 0...0 {
//            self.addToDoItem(title: String(i))
//        }

//        tableView.setEditing(true, animated: true)
        
    }

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addButton(_ sender: Any) {
        let alert = UIAlertController(title: "할 일 추가", message: "할 일을 입력하세요.", preferredStyle: .alert)
        let addToDoList = UIAlertAction(title: "추가", style: .destructive, handler: { [weak self] _ in
            print("추가 버튼 눌렀음")
            guard let text = alert.textFields?[0].text else { return }
            print("할 일 적음 \(text)")
            self?.addToDoItem(title: text)
            print("할 일 추가됨")
        })
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { _ in
            print("취소됨")
        }
        
        alert.addAction(addToDoList)
        alert.addAction(cancel)
        alert.addTextField { myTextField in
            myTextField.placeholder = "할 일을 적으세요"
        }

        self.present(alert, animated: true) { print( "alert 창 켜짐" )} //alert 창 띄워주는 코드
    }
        
    func addToDoItem(title: String) {
        self.list.append(Task(title: title, done: false)) //리스트에 할 일 추가해줌
        print("리스트에 할 일 추가")
        self.tableView.reloadData() //추가한 리스트를 보여줌
        print("할 일 추가 후 reloadData")
    }
    
    func cellTitleLabelUpdate(_ cell: UITableViewCell, _ task: Task) {
        if task.done {
            print("완료 상태")
            cell.textLabel?.attributedText = task.title.strikeThrough()
//            cell.textLabel?.textColor = .red
        } else {
            print("미완료 상태")
//            cell.textLabel?.textColor = .green
            cell.textLabel?.attributedText = NSAttributedString(string: task.title)
        }
    }
    
    @objc func didChangeSwitch(_ sender: UISwitch) {
        print("didChangeSwitch \(sender.tag)")
        
        // data update
        list[sender.tag].done = sender.isOn
        
        // cell update
        if let cell = sender.superview as? UITableViewCell {
            cellTitleLabelUpdate(cell, list[sender.tag])
        }
        
//        tableView.reloadData()
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection", section)
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) //셀 재사용
        let task = list[indexPath.row] //list 섹션의 행
        cellTitleLabelUpdate(cell, task)
        
        if cell.accessoryView == nil {
            print("new switch")
            let mySwitch = UISwitch()
            mySwitch.addTarget(self, action: #selector(didChangeSwitch(_ :)), for: .valueChanged)
            mySwitch.tag = indexPath.row
            mySwitch.isOn = task.done
            cell.accessoryView = mySwitch
        }
        else if let mySwitch = cell.accessoryView as? UISwitch {
            print("recycle switch \(mySwitch)")
            mySwitch.tag = indexPath.row
            mySwitch.isOn = task.done
        }
        
        return cell
    }
    
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        true
//    }
}

// 삭제
extension ViewController: UITableViewDelegate {
    
    // 특정 indexpath의 로우의 editingStyle을 설정
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 배열에서 indexPath.row에 해당하는 값 제거하기
        list.remove(at: indexPath.row)
        // 해당 cell을 tableview에서 없애기(UI적 요소)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

extension String {
    func strikeThrough() -> NSAttributedString {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, 
                            value: NSUnderlineStyle.single.rawValue,
                            range: NSMakeRange(0, attributeString.length))
            attributeString.addAttribute(NSAttributedString.Key.foregroundColor,
                            value: UIColor.gray,
                            range: NSMakeRange(0, attributeString.length))
            return attributeString
    }
}
