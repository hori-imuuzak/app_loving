//
//  PartnerList.swift
//  loving
//
//  Created by 堀知海 on 2020/05/21.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI

struct RequestTo: View {
    init(partners: [PartnerItem]) {
        self.partners = partners

        UITableView.appearance().separatorStyle = .none
    }

    var partners: [PartnerItem] = []
    var body: some View {
        NavigationView {
            VStack {
                Text("誰にリクエストしますか？")
                    .font(.system(size: Const.FontSize.L))
                List(partners) { partner in
                    PartnerItemRow(name: partner.name)
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct RequestTo_Previews: PreviewProvider {
    static var previews: some View {
        RequestTo(partners: [
            PartnerItem(name: "旦那さん"),
            PartnerItem(name: "ママ"),
            PartnerItem(name: "息子ちゃん")
        ])
    }
}
