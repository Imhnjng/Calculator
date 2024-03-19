//
//  ViewController.swift
//  ToDoList
//
//  Created by IMHYEONJEONG on 3/19/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let button = UIButton(type: .system) // 시스템 스타일의 버튼 생성
    let tableView = UITableView()
    
    var toDoList: [String] = ["사과먹기", "고양이 이뻐해주기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        listTableView()
        addListButton()
        
    }
    
    struct Todo {
        // 고유값 id (Int) - var id: Int와 같은 식으로 구성할 수 있겠죠!
        var id: Int
      // 타이틀 (String)
        let title: String
      // 완료 여부 (Bool)
        let completList: Bool
      // 기타 추가로 나타내고 싶은 데이터가 있으면 구성해줍니다.
    }
    
    //추가 버튼
    func addListButton() {
//        button.setBackgroundImage(UIImage(named: "jerry4"), for: .normal)
        button.setTitle("+", for: .normal) // 버튼에 표시될 텍스트
        button.backgroundColor = UIColor.blue // 버튼 배경색 설정
        button.setTitleColor(UIColor.white, for: .normal) // 버튼 텍스트 색상 설정
        button.frame = CGRect(x: 200, y: 50, width: 50, height: 50) // 버튼의 프레임 설정 (위치와 크기)
        self.view.addSubview(button)
//             버튼에 대한 액션 설정 (버튼이 탭되었을 때 실행될 함수)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
      print("리스트 추가 버튼이 눌렸습니다!")
    }
    
    
    // 리스트 테이블 뷰
    func listTableView() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }
    
    // UITableViewDataSource
            
            /* [필수] 테이블의 행 수를 보고합니다. */
            // section: 테이블뷰의 section을 나타내는 식별자 입니다. 이를 바탕으로 해당 섹션의 count를 반환합니다.
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return toDoList.count
        }
        
            /* [필수] 테이블의 각 행에 대한 셀을 제공합니다. */
            // indexPath: 테이블뷰에서 Row(행)을 찾는 경로입니다. 이를 바탕으로 적절한 cell을 반환합니다.
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = toDoList[indexPath.row]
            return cell
        }
          
        // UITableViewDelegate
            
            /* 행이 선택되었을 때 호출 */
            // indexPath: 테이블뷰에서 선택된 Row(행)을 찾는 경로입니다. 이를 바탕으로 어떤 행이 선택되었는지 파악할 수 있습니다.
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("Selected: \(toDoList[indexPath.row])")
            tableView.deselectRow(at: indexPath, animated: false)
        }

    


}

