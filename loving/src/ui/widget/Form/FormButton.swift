//
//  ConfrimButton.swift
//  loving
//
//  Created by 堀知海 on 2020/05/27.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI

struct FormButton: View {
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            Text(self.text).foregroundColor(Color.white)
        }
        .padding(.vertical, Const.Padding.M)
        .padding(.horizontal, 32)
        .background(LinearGradient(gradient: Gradient(colors: [Const.Palette.Primary, Const.Palette.Secondary]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(24)
    }
}

struct ConfirmButton_Previews: PreviewProvider {
    static var previews: some View {
        FormButton(text: "Save", action: {})
    }
}
