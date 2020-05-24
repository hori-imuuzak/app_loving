//
//  ImageMessage.swift
//  loving
//
//  Created by 堀知海 on 2020/05/24.
//  Copyright © 2020 umiapp. All rights reserved.
//

protocol ImageMessage {
    var to: User { get }
    var from: User { get }
    var imageUrl: String { get }
}
