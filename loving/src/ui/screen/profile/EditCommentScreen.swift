//
//  EditComment.swift
//  loving
//
//  Created by 堀知海 on 2020/05/27.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI

struct EditCommentScreen: View {
    @Environment(\.presentationMode) var presentation
    
    @State var comment: String = ""
    var onSaveComment: (_: String) -> Void
    
    var body: some View {
        VStack {
            TextInput(label: "ひとこと", placeHolder: "あなたを表す一言を入力してください。", text: self.$comment)
            FormButton(text: "保存する", action: {
                self.onSaveComment(self.comment)
                self.presentation.wrappedValue.dismiss()
            })
            .padding(.top, Const.Padding.M)
        }
        .padding(.horizontal, Const.Padding.L)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct EditCommentScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditCommentScreen(onSaveComment: {_ in })
    }
}
