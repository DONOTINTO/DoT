//
//  TripIntroCollectionViewCell.swift
//  DoT
//
//  Created by 이중엽 on 3/15/24.
//

import UIKit
import SnapKit

final class TripIntroCollectionViewCell: BaseCollectionViewCell {
    
    private let tripTitle = UILabel()
    private let tripDay = UILabel()
    
    override func configureHierarchy() {
        
        [tripTitle, tripDay].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        
        tripTitle.snp.makeConstraints {
            $0.top.equalTo(contentView).inset(10)
            $0.horizontalEdges.equalTo(contentView).inset(10)
        }
        
        tripDay.snp.makeConstraints {
            $0.top.equalTo(tripTitle.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(contentView).inset(10)
            $0.bottom.equalTo(contentView).inset(20)
        }
    }
    
    override func configureView() {
        
        tripTitle.configure(text: "여행 제목", fontSize: .extraLarge, fontScale: .Bold)
        tripDay.configure(text: "여행 일차", fontSize: .medium, fontScale: .Bold)
    }
    
    func configure(data: TripIntro) {
        
        tripTitle.text = data.title
        tripDay.text = data.preriod
    }
}
