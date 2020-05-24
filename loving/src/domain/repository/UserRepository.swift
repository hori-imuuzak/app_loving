//
//  UserRepository.swift
//  loving
//
//  Created by 堀知海 on 2020/05/24.
//  Copyright © 2020 umiapp. All rights reserved.
//

import RxSwift

protocol UserRepository {
    static var instance: UserRepository { get }

    func get(uid: String) -> Observable<User>
    func create(user: User) -> Observable<User>
    func update(user: User) -> Observable<User>
}
