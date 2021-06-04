//
//  NetworkAPI.swift
//  CoinTracker
//
//  Created by ahmet on 29.05.2021.
//

import Foundation

class NetworkAPI {
    
    static let shared = NetworkAPI()
    
    private struct Constants {
        static let apiKey = "2595F8D5-4A7F-4AFC-9431-79F25BE75D45"
        static let assetsEndpoint = "https://rest-sandbox.coinapi.io/v1/assets"
    }
    
    public var icons: [IconModel] = []
    
    private var whenReadeyBlock : ((Result<[CryptoModel],Error>) -> Void)?
    
    public func getAllCryptoData(completion: @escaping (Result<[CryptoModel],Error>) -> Void){
        
        guard !icons.isEmpty else {
            whenReadeyBlock = completion
            return
        }
        
        guard let url = URL(string: Constants.assetsEndpoint + "?apikey=" + Constants.apiKey) else {  // 1
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data,_,error in  // 2
            guard let data = data , error == nil else {
                return
            }
            do {
                let cryptos = try JSONDecoder().decode([CryptoModel].self, from: data) // 3

                completion(.success(cryptos.sorted { first,second -> Bool in
                    return first.price_usd ?? 0 > second.price_usd ?? 0
                }))
                
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    public func getAllIcons(){
        guard let url = URL(string: "https://rest-sandbox.coinapi.io/v1/assets/icons/55?apikey=2595F8D5-4A7F-4AFC-9431-79F25BE75D45") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data,_,error in
            guard let data = data , error == nil else {
                return
            }
            do {
                self.icons = try JSONDecoder().decode([IconModel].self, from: data)
                if let completion = self.whenReadeyBlock {
                    self.getAllCryptoData(completion: completion)
                }
            }
            catch{

            }
        }
        task.resume()
        
    }
    
    
    
}
