//
//  PartnerItemRow.swift
//  loving
//
//  Created by 堀知海 on 2020/05/21.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI
import URLImage

struct PartnerItemRow: View {
    var name: String
    var message: String = ""
    
    var body: some View {
        VStack() {
            Button(action: {}) {
                HStack() {
                    URLImage(URL(string: "https://ibb.co/kGTwxbW")!, placeholder: Image("profile_default").resizable())
                    .frame(width: 32, height: 32, alignment: .center)
                    VStack(alignment: .leading) {
                        Text(self.name)
                        Text(self.message)
                            .font(.system(size: Const.FontSize.S))
                            .foregroundColor(Color.gray)
                            .padding(.top, Const.Padding.S)
                        .padding(.top, Const.Padding.S)
                    }
                    .padding(.leading, Const.Padding.M)
                    Spacer()
                }
            }
            .foregroundColor(Color.black)
            .padding(Const.Padding.L)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: Const.CornerRadius))
        .shadow(color: Color.gray, radius: Const.Shadow)
    }
}

#if DEBUG
struct PartnerItemRow_Preview: PreviewProvider {
    static var previews: some View {
        VStack() {
            PartnerItemRow(name: "旦那さん")
            Divider().padding(.top, 16)
            PartnerItemRow(name: "旦那さん", message: "新着のメッセージがあります")
        }
    }
}
#endif
