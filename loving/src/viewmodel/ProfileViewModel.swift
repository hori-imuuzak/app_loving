//
//  ProfileViewModel.swift
//  loving
//
//  Created by 堀知海 on 2020/05/24.
//  Copyright © 2020 umiapp. All rights reserved.
//

import RxSwift

protocol ProfileViewModelInputs {
    func getUser()
    func updateName(_: String)
    func updateComment(_: String)
}

protocol ProfileViewModelOutputs {
    var userId: Observable<String> { get }
    var name: Observable<String> { get }
    var profileImageUrl: Observable<String> { get }
    var coverImageUrl: Observable<String> { get }
    var comment: Observable<String> { get }
}

protocol ProfileViewModelType {
    var inputs: ProfileViewModelInputs { get }
    var outputs: ProfileViewModelOutputs { get }
}

struct ProfileViewModel: ProfileViewModelType, ProfileViewModelInputs, ProfileViewModelOutputs {
    private var accountRepository: AccountRepository
    private var userRepository: UserRepository
    private var storage: StorageProtocol
    
    init(accountRepository: AccountRepository, userRepository: UserRepository, storage: StorageProtocol) {
        self.accountRepository = accountRepository
        self.userRepository = userRepository
        self.storage = storage
    }

    var inputs: ProfileViewModelInputs { return self }
    var outputs: ProfileViewModelOutputs { return self }
    
    private var userSubject = BehaviorSubject<User?>(value: nil)
    
    var userId: Observable<String> { return userSubject.map({ $0?.uid ?? "" }) }
    var name: Observable<String> { return userSubject.map({ $0?.name ?? "" }) }
    var profileImageUrl: Observable<String> { return userSubject.flatMap({ self.storage.getUrl($0?.profileImageUrl ?? "") }) }
    var coverImageUrl: Observable<String> { return userSubject.flatMap({ self.storage.getUrl($0?.profileCoverUrl ?? "") }) }
    var comment: Observable<String> { return userSubject.map({ $0?.comment ?? "" }) }
    
    func getUser() {
        self.accountRepository
            .getLoginUser()
            .subscribe(onNext: { user in
                self.userSubject.onNext(user)
            })
    }
    
    func updateName(_ name: String) {
        guard let user = try? userSubject.value() else { return }

        let updateUser = User(
            uid: user.uid,
            name: name,
            comment: user.comment,
            profileImageUrl: user.profileImageUrl,
            profileCoverUrl: user.profileCoverUrl
        )
        
        self.updateUser(updateUser)
    }
    
    func updateComment(_ comment: String) {
        guard let user = try? userSubject.value() else { return }

        let updateUser = User(
            uid: user.uid,
            name: user.name,
            comment: comment,
            profileImageUrl: user.profileImageUrl,
            profileCoverUrl: user.profileCoverUrl
        )
        
        self.updateUser(updateUser)
    }
    
    private func updateUser(_ user: User) {
        self.userRepository.update(user: user)
            .subscribe(onNext: { user in
                self.userSubject.onNext(user)
            }, onError: { error in
                
            })
    }
}
