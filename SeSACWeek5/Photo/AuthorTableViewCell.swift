//
//  AuthorTableViewCell.swift
//  SeSAC7Week5
//
//  Created by Jack on 7/30/25.
//

import UIKit
import SnapKit

class AuthorTableViewCell: BaseTableViewCell {
 
    static let identifier = "AuthorTableViewCell"
    
    let authorImageView = UIImageView()
    let authorLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(authorImageView)
        contentView.addSubview(authorLabel)
    }
    
    override func configureLayout() {
        authorImageView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.size.equalTo(50)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(authorImageView.snp.trailing).offset(8)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        authorImageView.contentMode = .scaleAspectFill
        authorImageView.backgroundColor = .red
        authorLabel.numberOfLines = 0
        authorLabel.font = .systemFont(ofSize: 13)
    }

}
