//
//  IconModel.swift
//  CoinTracker
//
//  Created by ahmet on 30.05.2021.
//

import Foundation

struct IconModel: Codable {
    let asset_id: String
    let url: String
}

/*
 {
   "asset_id": "USD",
   "url": "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/0a4185f21a034a7cb866ba7076d8c73b.png"
 },
 */
