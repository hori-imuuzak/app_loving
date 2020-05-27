//
//  ProfileContent.swift
//  loving
//
//  Created by 堀知海 on 2020/05/20.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI

struct ProfileContent: View {
    var uid: String? = nil
    var comment: String? = nil
    var onSaveComment: (_: String) -> Void
    
    var body: some View {
        VStack() {
            ProfileItemRow(
                label: "PartnerID",
                text: "QRコードを表示する",
                isFirst: true,
                destination: AnyView(Text("Hoge"))
            )
            ProfileItemRow(
                label: "背景を設定",
                hint: "プロフィールの背景画像を変更できます",
                destination: AnyView(Text("Hoge"))
            )
            ProfileItemRow(
                label: "ひとこと",
                text: self.comment ?? "未設定",
                destination: AnyView(EditComment(onSaveComment: self.onSaveComment))
            )
            ProfileItemRow(
                label: "ログイン設定",
                hint: "再インストール時にデータを引き継ぐことができます",
                text: "未設定",
                destination: AnyView(Text("Hoge"))
            )
            ProfileItemRow(
                text: "アカウントを削除する",
                destination: AnyView(Text("Hoge"))
            )
        }
    }
}

#if DEBUG
struct ProfileContent_Preview: PreviewProvider {
    static var previews: some View {
        ProfileContent(
            onSaveComment: { _ in }
        )
    }
}
#endif
