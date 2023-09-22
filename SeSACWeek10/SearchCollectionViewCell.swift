//
//  SearchCollectionViewCell.swift
//  SeSACWeek10
//
//  Created by 백래훈 on 2023/09/21.
//

import UIKit
import SnapKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        imageView.backgroundColor = .systemYellow
        imageView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
        
        label.text = "테스트"
        label.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
        
    }
}
