//
//  PartnerRepository.swift
//  loving
//
//  Created by 堀知海 on 2020/05/28.
//  Copyright © 2020 umiapp. All rights reserved.
//

import RxSwift

protocol PartnerRepository {
    static var instance: PartnerRepository { get }

    func getList(uid: String) -> Observable<Array<Partner>>
    func find(partnerId: String) -> Observable<Partner?>
    func add(user: User, partner: Partner) -> Observable<Partner>
    func remove(user: User, partner: Partner) -> Observable<Partner>
}
