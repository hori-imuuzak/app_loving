//
//  PartnerList.swift
//  loving
//
//  Created by 堀知海 on 2020/05/21.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI

struct PartnerItem: Identifiable {
    let id: Int
    let name: String
}

struct PartnerList: View {
    init(partners: [PartnerItem]) {
        self.partners = partners

        UITableView.appearance().separatorStyle = .none
    }

    var partners: [PartnerItem] = []
    var body: some View {
        NavigationView {
            List(partners) { partner in
                PartnerItemRow(name: partner.name)
            }
            .navigationBarTitle(Text("パートナー"))
            .navigationBarItems(trailing:
                Button(action: {}) {
                    Image(systemName: "plus")
                }
            )
        }
    }
}

struct PartnerList_Previews: PreviewProvider {
    static var previews: some View {
        PartnerList(partners: [
            PartnerItem(id: 1, name: "旦那さん"),
            PartnerItem(id: 2, name: "ママ"),
            PartnerItem(id: 3, name: "息子ちゃん")
        ])
    }
}
