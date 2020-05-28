//
//  FirebasePartnerRepository.swift
//  loving
//
//  Created by 堀知海 on 2020/05/28.
//  Copyright © 2020 umiapp. All rights reserved.
//

import RxSwift

class FirebasePartnerRepository : PartnerRepository {
    private static var _instance: PartnerRepository? = nil
    static var instance: PartnerRepository {
        get {
            if _instance == nil {
                _instance = FirebasePartnerRepository()
            }
            
            return _instance!
        }
    }
    
    private init() {}
    
    func getList(uid: String) -> Observable<Array<Partner>> {
        return Observable.create { subscribe -> Disposable in
            FirebasePartner
                .collections(uid: uid)
                .getDocuments { snapshot, err in
                    if let err = err {
                        subscribe.onError(err)
                    }
                    
                    var users: Array<Partner> = []
                    snapshot?.documents.forEach { doc in
                        let data = doc.data()
                        FirebaseUser
                            .document(uid: data["uid"] as! String)
                            .getDocument { userSnapshot, err in
                                if let err = err {
                                    subscribe.onError(err)
                                }
                                
                                guard let userData = userSnapshot?.data() else {
                                    subscribe.onCompleted()
                                    return
                                }
                                users.append(Partner(
                                    uid: data["uid"] as! String,
                                    name: userData["name"] as! String,
                                    comment: userData["comment"] as! String,
                                    profileImageUrl: userData["profileImageUrl"] as! String,
                                    profileCoverUrl: userData["profileCoverUrl"] as! String
                                ))
                                
                                if (users.count == snapshot?.documents.count) {
                                    subscribe.onNext(users)
                                    subscribe.onCompleted()
                                }
                            }
                    }
                }
            
            return Disposables.create()
        }
    }
    
    func find(partnerId: String) -> Observable<Partner> {
        return Observable.create { subscribe -> Disposable in
            subscribe.onCompleted()
            return Disposables.create()
        }
    }
    
    func add(user: User, partner: Partner) -> Observable<Partner> {
        return Observable.create { subscribe -> Disposable in
            subscribe.onCompleted()
            return Disposables.create()
        }
    }
    
    func remove(user: User, partner: Partner) -> Observable<Partner> {
        return Observable.create { subscribe -> Disposable in
            subscribe.onCompleted()
            return Disposables.create()
        }
    }
}
