//
//  CryptoTableViewCellViewModel.swift
//  CoinTracker
//
//  Created by ahmet on 30.05.2021.
//

import Foundation

class CryptoTableViewCellViewModel {
    let name: String
    let symbol: String
    let price: String
    let icon_url: URL?
    var iconData: Data?   // cash işlemi yaptık class'a çevirdik çünkü structa letleri değiştirme imkanımız yoktu. ve init ile başlattık.
    
    init(name:String,symbol:String,price:String,iconUrl:URL?) {
        self.name = name
        self.symbol = symbol
        self.price = price
        self.icon_url = iconUrl
    }
}
