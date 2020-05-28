//
//  FirebasePartner.swift
//  loving
//
//  Created by 堀知海 on 2020/05/28.
//  Copyright © 2020 umiapp. All rights reserved.
//

import FirebaseFirestore

struct FirebasePartner : PartnerModel {
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
    
    static func collections(uid: String) -> CollectionReference {
        return Firestore
            .firestore()
            .collection("users")
            .document(uid)
            .collection("partners")
    }
    
    static func document(partnerUid: String) -> DocumentReference {
        return Firestore
            .firestore()
            .collection("users")
            .document(partnerUid)
    }
}
