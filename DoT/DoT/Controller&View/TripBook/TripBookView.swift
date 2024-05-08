//
//  TripBookView.swift
//  DoT
//
//  Created by 이중엽 on 4/9/24.
//

import UIKit
import SnapKit

class TripBookView: BaseView {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: TripBookCompositionalLayout.create())
    
    override func configureHierarchy() {
        
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
        collectionView.backgroundColor = .clear
    }
}
