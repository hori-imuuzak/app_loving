//
//  PostRequest.swift
//  loving
//
//  Created by 堀知海 on 2020/05/24.
//  Copyright © 2020 umiapp. All rights reserved.
//

struct PostRequest: UniqueIdentifiable {
    let uid: String
    let request: Request
    let to: User
    let from: User
    let title: String
    let comment: String
    let status: RequestStatus
}
