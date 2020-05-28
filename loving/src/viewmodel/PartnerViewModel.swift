//
//  PartnerViewModel.swift
//  loving
//
//  Created by 堀知海 on 2020/05/28.
//  Copyright © 2020 umiapp. All rights reserved.
//

import RxSwift
import FirebaseAuth

protocol PartnerViewModelInputs {
    func getPartnerList()
}

protocol PartnerViewModelOutputs {
    var partners: Observable<Array<Partner>> { get }
}

protocol PartnerViewModelType {
    var inputs: PartnerViewModelInputs { get }
    var outputs: PartnerViewModelOutputs { get }
}


struct PartnerViewModel: PartnerViewModelType, PartnerViewModelInputs, PartnerViewModelOutputs {
    private var partnerRepository: PartnerRepository
    
    init(partnerRepository: PartnerRepository) {
        self.partnerRepository = partnerRepository
    }
    
    var inputs: PartnerViewModelInputs { return self }
    var outputs: PartnerViewModelOutputs { return self }
    
    func getPartnerList() {
        if let uid = Auth.auth().currentUser?.uid {
            self.partnerRepository
                .getList(uid: uid)
                .subscribe(partnersSubject)
        }
    }
    
    private let partnersSubject = PublishSubject<Array<Partner>>()
    var partners: Observable<Array<Partner>> {
        return partnersSubject.map { $0 }
    }
    
}
