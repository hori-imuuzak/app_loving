//
//  Message.swift
//  loving
//
//  Created by 堀知海 on 2020/05/24.
//  Copyright © 2020 umiapp. All rights reserved.
//

struct Message: UniqueIdentifiable, TextMessage, ImageMessage {
    let uid: String
    let to: User
    let from: User
    var message: String
    var imageUrl: String
}
