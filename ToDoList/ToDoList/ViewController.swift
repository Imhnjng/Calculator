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
        
        // Drag & Drop 기능을 위한 부분
        tableView.dragInteractionEnabled = true // 드래그 지원 여부: bool
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        
//        for i in 0...2 {
////            self.addToDoItem(title: String(i))
//            self.list.append(Task(title: String(i), done: false))
//        }

        loadData()
//        tableView.setEditing(true, animated: true)
        
        
        //
        // apple
        //
//        if tableView.dataSource.conforms(to: UITableViewDataSource) {
//            let sectionCount = tableView.dataSource?.numberOfSections?(in: tableView)
//            for i in 0...sectionCount {
//                let rowCount = tableView.dataSource?.tableView(tableView, numberOfRowsInSection: i)
//                for a in 0...rowCount {
//                    tableView.dataSource?.tableView(tableView, cellForRowAt: IndexPath(index: a))
//                }
//            }
//        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addButton(_ sender: Any) {
        let alert = UIAlertController(title: "할 일 추가", message: "할 일을 입력하세요.", preferredStyle: .alert)
        let addToDoList = UIAlertAction(title: "추가", style: .destructive, handler: { [weak self] _ in
            print("추가 버튼 눌렀음")
            guard let text = alert.textFields?[0].text else { return }
            print("할 일 적음 \(text)")
            self?.addToDoItem(title: text)
            print("할 일 추가 중")
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
    
    @IBAction func onTestButtonClick(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            UserDefaults.standard.setValue("test", forKey: "A")
            let task = Task(title: "abc", done: true)
            UserDefaults.standard.setValue(task, forKey: "task")
        case 1:
            UserDefaults.standard.removeObject(forKey: "A")
            UserDefaults.standard.removeObject(forKey: "ToDoList")
            UserDefaults.standard.synchronize()
        case 2:
            let data = UserDefaults.standard.dictionaryRepresentation()
            print(data)
        default:
            break
        }
    }
    
    func loadData() {
        print("loadData")
        guard let toDoList = UserDefaults.standard.value(forKey: "ToDoList") as? [[String : Any]] else { return }
        
//        self.list.removeAll()
//        for todo in toDoList {
//            if let title = todo["title"] as? String, let done = todo["done"] as? Bool {
//                let task = Task(title: title, done: done)
//                self.list.append(task)
//            }
//        }
        
        self.list = toDoList.compactMap { todo -> Task? in
            guard let title = todo["title"] as? String, let done = todo["done"] as? Bool else { return nil }
            return Task(title: title, done: done)
        }
    }
    
    func saveData() {
        print("saveData")
//        var toDoList: [[String: Any]] = []
//        for task in self.list {
//            let dic = [
//                "title": task.title,
//                "done": task.done
//            ] as [String : Any]
//            toDoList.append(dic)
//        }
        let toDoList = self.list.map { task in
            ["title": task.title, "done": task.done]
        }
        UserDefaults.standard.setValue(toDoList, forKey: "ToDoList")
        UserDefaults.standard.synchronize()
    }
    
        
    func addToDoItem(title: String) {
        self.list.append(Task(title: title, done: false)) //리스트에 할 일 추가해줌
        saveData()
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
        print("didChangeSwitch \(sender)")
        guard let cell = sender.superview as? UITableViewCell else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        print("cell \(cell)")
        print("indexPath \(indexPath)")
        
        // data update
        list[indexPath.row].done = sender.isOn
        print("list[indexPath.row] \(list[indexPath.row])")
        saveData()
        
        // cell update
        cellTitleLabelUpdate(cell, list[indexPath.row])
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
        print("@@@@@ \(indexPath.row) \(task.done)")
        
        if cell.accessoryView == nil {
            print("new switch")
            let mySwitch = UISwitch()
            mySwitch.addTarget(self, action: #selector(didChangeSwitch(_ :)), for: .valueChanged)
//            mySwitch.tag = indexPath.row
            
            mySwitch.isOn = task.done
            cell.accessoryView = mySwitch
        }
        else if let mySwitch = cell.accessoryView as? UISwitch {
            print("recycle switch \(mySwitch)")
//            mySwitch.tag = indexPath.row
            mySwitch.isOn = task.done
        }
        
        return cell
    }
    
    // 셀 순서 바꾸기. 애니메이팅
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("\(sourceIndexPath.row) -> \(destinationIndexPath.row)")
        let moveCell = self.list[sourceIndexPath.row]
        self.list.remove(at: sourceIndexPath.row)
        self.list.insert(moveCell, at: destinationIndexPath.row)
        saveData()
        tableView.reloadData()
    }
    
}



extension ViewController: UITableViewDelegate {
    // 삭제
    // 특정 indexpath의 로우의 editingStyle을 설정 .delete
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    // 스와이프 하면 delect 버튼 생성
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        list.remove(at: indexPath.row)  // 배열에서 indexPath.row에 해당하는 값 제거하기
        saveData()
        tableView.deleteRows(at: [indexPath], with: .fade) // 해당 cell을 tableview에서 없애기(UI적 요소)
    }
    
    // 셀 선택 후 회색으로 선택 된 셀 원래대로 되돌리기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// 할 일 순서 바꾸기 기능
//참고자료 https://yoojin99.github.io/app/TableView-%EB%93%9C%EB%9E%98%EA%B7%B8-%EB%93%9C%EB%A1%AD/
extension ViewController: UITableViewDragDelegate {
func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
}
 
extension ViewController: UITableViewDropDelegate {
    
    //셀의 변경 위치를 시각적으로 보여줌. 옵션이고 구현 권장하는 메소드.
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    
    // 사용자가 스크린에서 손가락을 뗄 때 호출됨
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) { }
}


extension String {
    func strikeThrough() -> NSAttributedString {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
            //취소선
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                            value: NSUnderlineStyle.single.rawValue,
                            range: NSMakeRange(0, attributeString.length))
            //텍스트 회색으로 변경
            attributeString.addAttribute(NSAttributedString.Key.foregroundColor,
                            value: UIColor.gray,
                            range: NSMakeRange(0, attributeString.length))
            return attributeString
    }
}
