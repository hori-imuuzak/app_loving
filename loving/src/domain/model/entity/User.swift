//
//  User.swift
//  loving
//
//  Created by 堀知海 on 2020/05/24.
//  Copyright © 2020 umiapp. All rights reserved.
//

protocol UserModel: UniqueIdentifiable {
    var uid: String { get }
    var name: String { get }
    var comment: String { get }
    var profileImageUrl: String { get }
    var profileCoverUrl: String { get }
}

struct User: UserModel {
    var uid: String
    var name: String
    var comment: String
    var profileImageUrl: String
    var profileCoverUrl: String
    
    init(uid: String, name: String, comment: String, profileImageUrl: String, profileCoverUrl: String) {
        self.uid = uid
        self.name = name
        self.comment = comment
        self.profileImageUrl = profileImageUrl
        self.profileCoverUrl = profileCoverUrl
    }
}
