//
//  ViewController.swift
//  WishListApp
//
//  Created by IMHYEONJEONG on 4/9/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var persistentContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //     currentProduct가 set되면, imageView. titleLabel, descriptionLabel, priceLabel에 각각 적절한 값을 지정합니다.
    private var currentProduct: RemoteProduct? = nil {
        didSet {
            guard let currentProduct = self.currentProduct else { return }
            
            DispatchQueue.main.async {
                print("3333 isMainThread: \(Thread.current.isMainThread) name: \(Thread.current.name)")
                self.productImage.image = nil
                self.titleLabel.text = currentProduct.title
                self.descriptionLabel.text = currentProduct.description
                self.priceLabel.text = "$ \(currentProduct.price)"
            }
            
            DispatchQueue.global().async { [weak self] in
                print("4444 isMainThread: \(Thread.current.isMainThread) name: \(Thread.current.name)")
                if let data = try? Data(contentsOf: currentProduct.thumbnail), let image = UIImage(data: data) {
                    DispatchQueue.main.async { self?.productImage.image = image }
                }
            }
        }
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRemoteProduct()
    }

    @IBAction func skipButton(_ sender: Any) {
        fetchRemoteProduct()
    }
    
    // 위시리스트 담기
    @IBAction func saveProductButton(_ sender: Any) {
        print("위시리스트 담음 \(#function)")
        saveWishProduct()
    }
    
    // 위시리스트 보기
    @IBAction func wishListButton(_ sender: Any) {
        guard let wichListVC = self.storyboard?.instantiateViewController(
              identifier: "WishListViewController"
            ) else { return }
          
          self.navigationController?.pushViewController(wichListVC, animated: true)
    }
    
    // 랜덤으로 더미데이터 가져오기
    func fetchRemoteProduct() {
        let productID = Int.random(in: 1...100) // 1에서 100 사이의 랜덤 숫자 생성
        
        if let url = URL(string: "https://dummyjson.com/products/\(productID)") {
            print("isMainThread: \(Thread.current.isMainThread) name: \(Thread.current.name)")
            // URLSessionDataTask를 사용하여 비동기적으로 데이터 요청
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                print("2222 isMainThread: \(Thread.current.isMainThread) name: \(Thread.current.name)")
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    do {
                        // do에서 에러가 나면 catch 에서 처리해줌
                        let product = try JSONDecoder().decode(RemoteProduct.self, from: data)
                        print("Deocded Product: \(product)")
                        self.currentProduct = product
                    } catch {
                        print("Decode Error: \(error)")
                    }
                }
            }
            
            // 네트워크 요청 시작
            task.resume()
        }
    }
    
   
     //currentProduct를 가져와 Core Data에 저장합니다.
    private func saveWishProduct() {
        guard let context = self.persistentContainer?.viewContext else { return }

        guard let currentProduct = self.currentProduct else { return }

        let wishProduct = Product(context: context)
        
        wishProduct.id = Int64(currentProduct.id)
        wishProduct.title = currentProduct.title
        wishProduct.price = currentProduct.price
        wishProduct.thumbnail = currentProduct.thumbnail
        
        try? context.save()
    }
}

