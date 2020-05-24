//
//  TextMessage.swift
//  loving
//
//  Created by 堀知海 on 2020/05/24.
//  Copyright © 2020 umiapp. All rights reserved.
//

protocol TextMessage {
    var to: User { get }
    var from: User { get }
    var message: String { get }
}
