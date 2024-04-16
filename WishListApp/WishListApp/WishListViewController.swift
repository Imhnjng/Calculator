//
//  WishListViewController.swift
//  WishListApp
//
//  Created by IMHYEONJEONG on 4/12/24.
//

import UIKit
import CoreData

class WishListViewController: UIViewController {

    var persistentContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    
    var productList: [Product] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProductList()
        initRefresh()

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // CoreData에서 상품 정보를 불러와, productList 변수에 저장합니다.
    private func setProductList() {
        guard let context = self.persistentContainer?.viewContext else { return }
    
        let request = Product.fetchRequest()
    
        if let productList = try? context.fetch(request) {
            self.productList = productList
        }
    }
    
    
    // Table View Refresh
    func initRefresh() {
        refreshControl.addTarget(self, action: #selector(refreshTable(refresh: )), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refreshTable(refresh: UIRefreshControl) {
           print("새로고침 시작")
           
           DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
               print("새로고침 끝")
               refresh.endRefreshing()
           }
       }

}

extension WishListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let product = productList[indexPath.row]
        let id = product.id
        let title = product.title
        let price = product.price
//        let thumbnail = product.thumbnail
        
        cell.textLabel?.text = "[\(id)] \(title!) - $\(price)"
        return cell
    }

}

extension WishListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        // core data delete
        context.delete(productList[indexPath.row])
        try? context.save()
        
        // 배열에서 indexPath.row에 해당하는 값 제거하기
        productList.remove(at: indexPath.row)
        
        // 해당 cell을 tableview에서 없애기(UI적 요소)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
