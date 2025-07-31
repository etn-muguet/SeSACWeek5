//
//  PhotoTableViewCell.swift
//  SeSAC7Week5
//
//  Created by Jack on 7/30/25.
//

import UIKit
import SnapKit

class PhotoTableViewCell: BaseTableViewCell {

    static let identifier = "PhotoTableViewCell"
    
    let thumbnailImageView = UIImageView()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let overviewLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(overviewLabel)
    }
    
    override func configureLayout() {
        thumbnailImageView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.width.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints {
            $0.trailing.top.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
            $0.height.equalTo(18)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(18)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
            make.top.equalTo(subTitleLabel.snp.bottom)
        }
    }
    
    override func configureView() {
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.backgroundColor = .green
        overviewLabel.numberOfLines = 0
        overviewLabel.font = .systemFont(ofSize: 13)
    }


}
