//
//  File.swift
//  WishListApp
//
//  Created by IMHYEONJEONG on 4/9/24.
//

import Foundation


struct RemoteProduct: Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let thumbnail: URL
}
