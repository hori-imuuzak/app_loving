//
//  EditComment.swift
//  loving
//
//  Created by 堀知海 on 2020/05/27.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI

struct EditName: View {
    @Environment(\.presentationMode) var presentation
    
    @State var name: String = ""
    var onSaveName: (_: String) -> Void
    
    var body: some View {
        VStack {
            TextInput(label: "名前", placeHolder: "名前を入力してください", text: self.$name)
            FormButton(text: "保存する", action: {
                self.onSaveName(self.name)
                self.presentation.wrappedValue.dismiss()
            })
            .padding(.top, Const.Padding.M)
        }
        .padding(.horizontal, Const.Padding.L)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct EditName_Preview: PreviewProvider {
    static var previews: some View {
        EditName(onSaveName: {_ in })
    }
}
