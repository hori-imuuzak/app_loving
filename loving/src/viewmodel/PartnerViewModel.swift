//
//  PartnerViewModel.swift
//  loving
//
//  Created by 堀知海 on 2020/05/28.
//  Copyright © 2020 umiapp. All rights reserved.
//

import RxSwift

protocol PartnerViewModelInputs {
    func getPartnerList()
    func addPartner(to user: User, partner: Partner)
}

protocol PartnerViewModelOutputs {
    var partners: Observable<Array<Partner>> { get }
    var isSuccessAddPartner: Observable<Bool> { get }
}

protocol PartnerViewModelType {
    var inputs: PartnerViewModelInputs { get }
    var outputs: PartnerViewModelOutputs { get }
}

struct PartnerViewModel: PartnerViewModelType, PartnerViewModelInputs, PartnerViewModelOutputs {
    private var accountRepository: AccountRepository
    private var partnerRepository: PartnerRepository
    
    init(accountRepository: AccountRepository, partnerRepository: PartnerRepository) {
        self.accountRepository = accountRepository
        self.partnerRepository = partnerRepository
    }
    
    var inputs: PartnerViewModelInputs { return self }
    var outputs: PartnerViewModelOutputs { return self }
    
    func getPartnerList() {
        self.accountRepository
            .getLoginUser()
            .flatMap { loginUser -> Observable<Array<Partner>> in
                if let user = loginUser {
                    return self.partnerRepository
                        .getList(uid: user.uid)
                }
                
                return Observable.just([] as Array<Partner>)
            }
            .subscribe(partnersSubject)
    }
    
    func addPartner(to user: User, partner: Partner) {
        
    }
    
    private let partnersSubject = PublishSubject<Array<Partner>>()
    var partners: Observable<Array<Partner>> {
        return partnersSubject.map { $0 }
    }
    
    private let isSuccessAddPartnerSubject = PublishSubject<Bool>()
    var isSuccessAddPartner: Observable<Bool> { return isSuccessAddPartnerSubject.map{ $0 } }
}
