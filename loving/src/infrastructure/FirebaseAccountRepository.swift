//
//  FirebaseAccountRepository.swift
//  loving
//
//  Created by 堀知海 on 2020/05/28.
//  Copyright © 2020 umiapp. All rights reserved.
//

import RxSwift
import FirebaseAuth

class FirebaseAccountRepository : AccountRepository {
    static var _instance: AccountRepository? = nil
    static var instance: AccountRepository {
        get {
            if _instance == nil {
                _instance = FirebaseAccountRepository()
            }
            
            return _instance!
        }
    }
    
    private init() {}
    
    private var loginUser: User? = nil
    
    func getLoginUser() -> Observable<User?> {
        return Observable.create { subscribe -> Disposable in
            let uid = Auth.auth().currentUser?.uid
            
            if (uid == nil) {
                self.loginUser = nil
                subscribe.onNext(self.loginUser)
                subscribe.onCompleted()
            } else if (self.loginUser?.uid == uid) {
                subscribe.onNext(self.loginUser)
                subscribe.onCompleted()
            } else {
                FirebaseUser
                    .document(uid: uid!)
                    .getDocument { snapshot, err in
                        if let data = snapshot?.data() {
                            let user = User(
                                uid: uid!,
                                name: data["name"] as! String,
                                comment: data["comment"] as! String,
                                profileImageUrl: data["profileImageUrl"] as! String,
                                profileCoverUrl: data["profileCoverUrl"] as! String
                            )
                            self.loginUser = user
                            subscribe.onNext(user)
                        } else {
                            self.loginUser = nil
                            subscribe.onNext(self.loginUser)
                        }
                        subscribe.onCompleted()
                }
            }
            
            return Disposables.create()
        }
    }
    
}
