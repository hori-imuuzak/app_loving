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
    func addPartner(partner: Partner)
}

protocol PartnerViewModelOutputs {
    var partners: PublishSubject<Array<Partner>> { get }
    var foundPartner: PublishSubject<Partner?> { get }
    var isSuccessAddPartner: PublishSubject<Bool> { get }
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
    
    private var disposeBag = DisposeBag()
    
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
            .subscribe(self.partners)
            .disposed(by: self.disposeBag)
    }
    
    func findPartner(uid: String) {
        self.partnerRepository
            .find(partnerId: uid)
            .subscribe(onNext: { partner in
                self.foundPartner.onNext(partner)
            })
            .disposed(by: self.disposeBag)
    }
    
    func addPartner(partner: Partner) {
        self.accountRepository
            .getLoginUser()
            .flatMap { loginUser -> Observable<Partner> in
                if let user = loginUser {
                    return self.partnerRepository.add(user: user, partner: partner)
                }
                
                return Observable.just(partner)
        }.subscribe { _ in
            self.isSuccessAddPartner.onNext(true)
        }.disposed(by: self.disposeBag)
    }
    
    let partners = PublishSubject<Array<Partner>>()
    let foundPartner = PublishSubject<Partner?>()
    let isSuccessAddPartner = PublishSubject<Bool>()
}
