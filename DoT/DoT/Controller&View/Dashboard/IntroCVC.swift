//
//  IntroCollectionViewCell.swift
//  DoT
//
//  Created by 이중엽 on 3/8/24.
//

import UIKit
import SnapKit

final class IntroCollectionViewCell: BaseCollectionViewCell {
    
    let introLabel = UILabel()
    let tripDashboradPushButton = UIButton()
    
    override func configureHierarchy() {
        
        [introLabel, tripDashboradPushButton].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        
        introLabel.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView).inset(20)
            $0.leading.equalTo(contentView).inset(10)
        }
        
        tripDashboradPushButton.snp.makeConstraints {
            $0.verticalEdges.equalTo(introLabel)
            $0.width.height.equalTo(introLabel.snp.height)
            $0.trailing.equalTo(contentView)
            $0.leading.equalTo(introLabel.snp.trailing).offset(10)
        }
    }
    
    override func configureView() {
        
        introLabel.configure(text: "여행 제목\n 여행을 진행하고 있어요", fontSize: .large, fontScale: .Bold, numberOfLines: 2)
        introLabel.adjustsFontSizeToFitWidth = true
        
        let image = UIImage(systemName: "arrow.right")
        tripDashboradPushButton.configure(image: image)
        
        DispatchQueue.main.async {
            self.tripDashboradPushButton.layer.cornerRadius = self.tripDashboradPushButton.frame.width / 2
            self.tripDashboradPushButton.layer.masksToBounds = true
        }
    }
    
    func configure(title: String) {
        
        introLabel.configure(text: "\(title)\n여행이 진행되고 있어요", fontSize: .large, fontScale: .Bold, numberOfLines: 2)
    }
}