//
//  AddPartner.swift
//  loving
//
//  Created by 堀知海 on 2020/05/22.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI

struct AddPartner: View {
    let addPartner: () -> Void
    @State private var inputPartnerId = ""
    @State private var isFoundPartner = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("パートナーの追加").font(.title)
                Text("PartnerIDを利用して、追加したいパートナーを検索することができます。")
                    .font(.system(size: Const.FontSize.L))
                    .lineLimit(nil)
                    .padding(.top, Const.Padding.M)
                    .fixedSize(horizontal: false, vertical: true)
                Text("PartnerIDは、設定画面で確認できます。")
                    .font(.system(size: Const.FontSize.S))
                    .foregroundColor(Color.gray)
                    .padding(.top, Const.Padding.S)
            }
            TextField("PartnerIDを入力してください", text: $inputPartnerId)
            Button("検索") {
                // TODO mock
                self.isFoundPartner = true
                self.inputPartnerId = ""
                UIApplication.shared.endEditing()
            }.padding(.top, Const.Padding.M)
            if self.isFoundPartner {
                VStack {
                    PartnerItemRow(name: "見つけた相手の名前", profileImage: "")
                    Button("追加する") {
                        self.addPartner()
                    }.padding(.top, Const.Padding.M)
                }.padding(.top, Const.Padding.L)
            }
            Spacer()
        }
        .padding(.vertical, 120)
        .padding(.horizontal, Const.Padding.M)
    }
}

struct AddPartner_Previews: PreviewProvider {
    static var previews: some View {
        AddPartner(addPartner: {})
    }
}
