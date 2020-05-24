//
//  ProfileContent.swift
//  loving
//
//  Created by 堀知海 on 2020/05/20.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI

struct ProfileContent: View {
    var body: some View {
        VStack() {
            ProfileItemRow(
                label: "PartnerID",
                text: "hogehogehoge",
                isFirst: true
            )
            ProfileItemRow(
                label: "背景を設定",
                hint: "プロフィールの背景画像を変更できます"
            )
            ProfileItemRow(
                label: "ひとこと",
                text: "未設定"
            )
            ProfileItemRow(
                label: "ログイン設定",
                hint: "再インストール時にデータを引き継ぐことができます",
                text: "未設定"
            )
            ProfileItemRow(
                text: "アカウントを削除する"
            )
        }
    }
}

#if DEBUG
struct ProfileContent_Preview: PreviewProvider {
    static var previews: some View {
        ProfileContent()
    }
}
#endif
