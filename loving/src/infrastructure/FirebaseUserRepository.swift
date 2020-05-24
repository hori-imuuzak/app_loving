//
//  FirebaseUserRepository.swift
//  loving
//
//  Created by 堀知海 on 2020/05/24.
//  Copyright © 2020 umiapp. All rights reserved.
//

import RxSwift

class FirebaseUserRepository: UserRepository {
    private static var _instance: UserRepository? = nil
    static var instance: UserRepository {
        get {
            if _instance == nil {
                _instance = FirebaseUserRepository()
            }
            
            return _instance!
        }
    }
    
    func get(uid: String) -> Observable<User> {
        return Observable.create { subscribe -> Disposable in
            FirebaseUser
                .document(uid: uid)
                .getDocument(completion: { doc, err in
                    if let err = err {
                        subscribe.onError(err)
                    } else {
                        if let data = doc?.data() {
                            subscribe.onNext(User(
                                uid: uid,
                                name: data["name"] as? String ?? "",
                                comment: data["comment"] as? String ?? "",
                                profileImageUrl: data["profileImageUrl"] as? String ?? "",
                                profileCoverUrl: data["profileCoverUrl"] as? String ?? ""
                            ))
                        } else {
                            subscribe.onCompleted()
                        }
                    }
                })
            
            return Disposables.create()
        }
    }
    
    func create(user: User) -> Observable<User> {
        return Observable.create { subscribe -> Disposable in
            FirebaseUser
                .document(uid: user.uid)
                .setData([
                    "name": user.name,
                    "comment": user.comment,
                    "profileImageUrl": user.profileImageUrl,
                    "profileCoverUrl": user.profileCoverUrl
                ]) { err in
                    if let err = err {
                        subscribe.onError(err)
                    } else {
                        subscribe.onNext(user)
                        subscribe.onCompleted()
                    }
            }
            
            return Disposables.create()
        }
    }
    
    func update(user: User) -> Observable<User> {
        return Observable.create { subscribe -> Disposable in
            FirebaseUser
                .document(uid: user.uid)
                .updateData([
                    "name": user.name,
                    "comment": user.comment,
                    "profileImageUrl": user.profileImageUrl,
                    "profileCoverUrl": user.profileCoverUrl
                ]) { err in
                    if let err = err {
                        subscribe.onError(err)
                    } else {
                        subscribe.onNext(user)
                        subscribe.onCompleted()
                    }
            }
            
            return Disposables.create()
        }
    }
}
