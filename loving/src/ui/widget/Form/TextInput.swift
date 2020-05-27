//
//  TextInput.swift
//  loving
//
//  Created by 堀知海 on 2020/05/27.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI

struct TextInput: View {
    var label: String
    var placeHolder: String = ""
    
    var text: Binding<String>
    
    var body: some View {
        VStack(alignment: .leading, spacing: Const.Padding.S) {
            Text(self.label).font(.headline)
            TextField(self.placeHolder, text: self.text)
                .padding(.all, Const.Padding.L)
                .background(Const.Palette.FormBackground)
                .cornerRadius(Const.InputCornerRadius)
        }
    }
}

struct TextInput_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextInput(label: "name",  text: .constant(""))
            TextInput(label: "body", placeHolder: "hint", text: .constant(""))
        }
    }
}
