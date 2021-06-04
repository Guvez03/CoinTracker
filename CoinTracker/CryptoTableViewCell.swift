//
//  CyrptoTableViewCell.swift
//  CoinTracker
//
//  Created by ahmet on 29.05.2021.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    
    static let identifier = "CryptoTableViewCell"

    // SubViews
   
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 24 , weight: .medium)
        return label
    }()
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20 , weight: .regular)
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 22 , weight: .semibold)
        return label
    }()
    private let iconImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    // init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemGray5
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(iconImageView)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // layout
    
    override func layoutSubviews() {  // nedir
        super.layoutSubviews()
        
        iconImageView.sizeToFit()

        let size: CGFloat = contentView.frame.size.height/1.3
        iconImageView.frame = CGRect(x: 10, y: (contentView.frame.size.height-size)/2, width: size, height: size)
        
        nameLabel.sizeToFit()
        priceLabel.sizeToFit()
        symbolLabel.sizeToFit()
        
        nameLabel.frame = CGRect(x: 30 + size, y: 0, width: contentView.frame.size.width/2, height: contentView.frame.size.height/2)
        symbolLabel.frame = CGRect(x: 30 + size, y: contentView.frame.size.height/2, width: contentView.frame.size.width/2, height: contentView.frame.size.height/2)
        priceLabel.frame = CGRect(x: contentView.frame.size.width/2, y: 0, width: (contentView.frame.size.width/2)-15, height: contentView.frame.size.height)

    }
    
    override func prepareForReuse() {  // nedir
        super.prepareForReuse()
        iconImageView.image = nil
        nameLabel.text = nil
        priceLabel.text = nil
        symbolLabel.text = nil

    }
    
    // configure
    
    func configure(with viewModel: CryptoTableViewCellViewModel) {
        nameLabel.text = viewModel.name
        symbolLabel.text = viewModel.symbol
        priceLabel.text = viewModel.price
        
        if let data = viewModel.iconData {  // iconData var ise direk atıyo yoksa servisten çekiyor.
            iconImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.icon_url {
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _ , _ in  // ne işe yarıyordu
                if let data = data {
                    viewModel.iconData = data
                    DispatchQueue.main.async {
                        self?.iconImageView.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }
    }

}
