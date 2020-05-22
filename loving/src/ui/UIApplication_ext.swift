//
//  UIApplication_ext.swift
//  loving
//
//  Created by 堀知海 on 2020/05/22.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
