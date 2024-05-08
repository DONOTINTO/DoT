//
//  TripBookViewModel.swift
//  DoT
//
//  Created by 이중엽 on 5/7/24.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

final class TripBookViewModel {
 
    private let realmManager = try? RealmManager()
    
    let refreshObservable = PublishRelay<Void>()
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        
        let fetchDataObservable = PublishRelay<Void>()
    }
    
    struct Output {
        
        let tripBookSectionData: Driver<[TripBookSection]>
    }
    
    func transform(input: Input) -> Output {
        
        let tripBookSection = PublishRelay<[TripBookSection]>()
        
        input.fetchDataObservable
            .subscribe(with: self) { owner, _ in
                
                guard let realmManager = owner.realmManager else { return }
                
                var data = realmManager.fetch(TripInfoDTO.self).map { $0.translate() }
                data.sort { $0.startDate < $1.startDate }
                
                let tripBookSuccess = [TripBookSection(items: data)]
                
                tripBookSection.accept(tripBookSuccess)
            }
            .disposed(by: disposeBag)
        
        return Output(tripBookSectionData: tripBookSection.asDriver(onErrorJustReturn: []))
    }
}

struct TripBookSection {
    
    var items: [TripInfo]
}

extension TripBookSection: SectionModelType {
    
    typealias Item = TripInfo
    
    init(original: TripBookSection, items: [TripInfo]) {
        
        self = original
        self.items = items
    }
}
