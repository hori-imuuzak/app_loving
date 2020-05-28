//
//  AccountRepository.swift
//  loving
//
//  Created by 堀知海 on 2020/05/28.
//  Copyright © 2020 umiapp. All rights reserved.
//

import RxSwift

protocol AccountRepository {
    static var instance: AccountRepository { get }
    
    func getLoginUser() -> Observable<User?>
}
