//
//  ExpenseCollectionViewCell.swift
//  DoT
//
//  Created by 이중엽 on 3/15/24.
//

import UIKit
import SnapKit

class ExpenseCollectionViewCell: BaseCollectionViewCell {
    
    let categoryLabel = UILabel()
    let expenseLabel = UILabel()
    let remainLabel = UILabel()
    
    override func configureHierarchy() {
        
        [categoryLabel, expenseLabel, remainLabel].forEach{ contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).inset(10)
            $0.leading.equalTo(contentView).inset(20)
        }
        
        expenseLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).inset(10)
            $0.trailing.equalTo(contentView).inset(20)
            $0.leading.greaterThanOrEqualTo(categoryLabel.snp.trailing).offset(10)
        }
        
        remainLabel.snp.makeConstraints {
            $0.top.equalTo(expenseLabel.snp.bottom).offset(10)
            $0.trailing.equalTo(contentView).inset(20)
            $0.bottom.equalTo(contentView).inset(10)
        }
    }
    
    override func configureView() {
        
        contentView.backgroundColor = .whiteBlack
        categoryLabel.configure(text: "카테고리", fontSize: .medium, fontScale: .Bold, color: .justGray)
        expenseLabel.configure(text: "130,000원", fontSize: .large, fontScale: .Bold)
        remainLabel.configure(text: "500,000원", fontSize: .medium, fontScale: .Bold, color: .justGray)
    }
}