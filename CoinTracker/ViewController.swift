//
//  ViewController.swift
//  CoinTracker
//
//  Created by ahmet on 29.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var viewModel = [CryptoTableViewCellViewModel]()
    
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.allowsFloats = true
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.formatterBehavior = .default
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crypto Tracker"
        tableView.backgroundColor = .systemGray5
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        NetworkAPI.shared.getAllCryptoData { [weak self] result in  // bu tür kullanımı completion kullandığımız için kullanabiliriz.
            
            switch result {
            case .success(let models):
                
                /* models ile tüm
                 [CoinTracker.CryptoModel(asset_id: Optional("YFI"), name: Optional("YFI"), price_usd: Optional(41728.645), id_icon: nil),
                 CoinTracker.CryptoModel(asset_id: Optional("BTC"), name: Optional("Bitcoin"), price_usd: Optional(35361.44), id_icon: Optional("4caf2b16-a017-4e26-a348-2cea69c34cba"))]
                 dizisi içersindeki veriler  gelir. */
                
                self?.viewModel = models.map({ model in
                    /* model ile ise
                     CryptoModel(asset_id: Optional("WBTC"), name: Optional("WBTC"), price_usd: Optional(35361.38), id_icon: Optional("23127c42-ad85-466d-b735-ebda1122c903"))
                     şeklinde tek tek alırız. */
                    
                    let price = model.price_usd ?? 0   // gelen pricate türü 33858.637576992151013846832455 bu şekilde bunu para birimlerine dönüştürüyor şekilde ayırıyor
                    let formatter = ViewController.numberFormatter
                    let priceString = formatter.string(from: NSNumber(value: price))
                    
                    let iconUrl = URL(string: NetworkAPI.shared.icons.filter({ icon in
                        icon.asset_id == model.asset_id
                    }).first?.url ?? ""  // first.url burada ne işe yarıyor.
                    )
                    return CryptoTableViewCellViewModel(name: model.name ?? "N/A", symbol: model.asset_id ?? "", price: priceString ?? "N/A",iconUrl:iconUrl)
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
        
    }
    override func viewDidLayoutSubviews() { //???
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds // what is different frame and bounds
    }
}
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier, for: indexPath) as? CryptoTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
