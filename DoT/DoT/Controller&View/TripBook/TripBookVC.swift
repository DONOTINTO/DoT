//
//  TripBookViewController.swift
//  DoT
//
//  Created by 이중엽 on 4/9/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class TripBookViewController: BaseViewController<TripBookView> {
    
    let viewModel = TripBookViewModel()
    
    private var dataSource: RxDataSources.RxCollectionViewSectionedReloadDataSource<TripBookSection>!
    private var disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.refreshObservable.accept(())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func bindData() {
                
        let input = TripBookViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.tripBookSectionData
            .drive(layoutView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.refreshObservable
            .bind(with: self) { owner, _ in
                input.fetchDataObservable.accept(())
            }
            .disposed(by: disposeBag)
        
        layoutView.collectionView.rx.itemSelected
            .bind(with: self) { owner, indexPath in
                
                let tripInfo = owner.dataSource[indexPath.section].items
                let nextVC = TripDashboardViewController()
                nextVC.tripDashboardVM.tripInfo = tripInfo[indexPath.item]
                
                owner.navigationController?.pushViewController(nextVC, animated: true)
                
            }.disposed(by: disposeBag)
    }
    
    override func configureCollectionView() {
        
        layoutView.collectionView.register(TripCardCollectionViewCell.self, forCellWithReuseIdentifier: TripCardCollectionViewCell.identifier)
        
        dataSource = RxDataSources.RxCollectionViewSectionedReloadDataSource<TripBookSection> { dataSource, collectionView, indexPath, item in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TripCardCollectionViewCell.identifier, for: indexPath) as? TripCardCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configure(data: item)
            
            return cell
        }
    }
}
