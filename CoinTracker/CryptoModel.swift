//
//  CryptoModel.swift
//  CoinTracker
//
//  Created by ahmet on 29.05.2021.
//

import Foundation

struct CryptoModel: Codable{
    
    let asset_id: String?
    let name: String?
    let price_usd: Float?
    let id_icon: String?
 
}

/*
 {
    "asset_id": "BTC",
    "name": "Bitcoin",
    "type_is_crypto": 1,
    "data_start": "2010-07-17",
    "data_end": "2021-05-29",
    "data_quote_start": "2014-02-24T17:43:05.0000000Z",
    "data_quote_end": "2021-05-29T16:42:47.3349389Z",
    "data_orderbook_start": "2014-02-24T17:43:05.0000000Z",
    "data_orderbook_end": "2020-08-05T14:38:38.3413202Z",
    "data_trade_start": "2010-07-17T23:09:17.0000000Z",
    "data_trade_end": "2021-05-29T14:15:03.4300000Z",
    "data_symbols_count": 55254,
    "volume_1hrs_usd": 6772999461067.03,
    "volume_1day_usd": 168505543673468.33,
    "volume_1mth_usd": 8477753118289699.81,
    "price_usd": 33858.637576992151013846832455,
    "id_icon": "4caf2b16-a017-4e26-a348-2cea69c34cba"
  }
 */




