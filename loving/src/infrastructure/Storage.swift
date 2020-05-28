//
//  Storage.swift
//  loving
//
//  Created by 堀知海 on 2020/05/28.
//  Copyright © 2020 umiapp. All rights reserved.
//

import RxSwift
import FirebaseStorage

protocol StorageProtocol {
    func getUrl(_ path: String) -> Observable<String>
}

struct FirebaseStorageImpl: StorageProtocol {
    func getUrl(_ path: String) -> Observable<String> {
        return Observable.create { (subscribe) -> Disposable in            
            Storage.storage().reference(withPath: path).downloadURL { (url: URL?, err) in
                if let err = err {
                    subscribe.onError(err)
                } else {
                    subscribe.onNext(url?.absoluteString ?? "")
                }
                subscribe.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}
