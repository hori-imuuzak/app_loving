//
//  PartnerList.swift
//  loving
//
//  Created by 堀知海 on 2020/05/21.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI
import RxSwift

extension Identifiable where Self: Hashable {
    typealias ID = Self
    var id: Self { self }
}

struct PartnerList: View {
    init(partners: [PartnerItem], onAddedPartner: @escaping () -> Void) {
        self.partners = partners

        UITableView.appearance().separatorStyle = .none
        self.onAddedPartner = onAddedPartner
    }
    
    var onAddedPartner: () -> Void
    @State private var isShowAddPartnerView = false

    var partners: [PartnerItem] = []
    var body: some View {
        NavigationView {
            VStack {
                if partners.isEmpty {
                    Text("パートナーを追加しましょう！")
                    Text("QRコードで簡単に追加できます。")
                } else {
                    List(partners) { partner in
                        PartnerItemRow(
                            name: partner.name,
                            profileImage: partner.profileImage,
                            message: partner.message
                        )
                    }
                }
            }
            .navigationBarTitle(Text("パートナー"))
            .navigationBarItems(trailing:
                Button(action: self.onClickAdd) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: self.$isShowAddPartnerView) {
                    AddPartnerView(onAddedPartner: {
                        self.isShowAddPartnerView = false
                        self.onAddedPartner()
                    })
                }
            )
        }
    }
    
    private func onClickAdd() {
        self.isShowAddPartnerView = true
    }
}

struct PartnerList_Previews: PreviewProvider {
    static var previews: some View {
        PartnerList(
            partners: [
                PartnerItem(name: "旦那さん", profileImage: "", message: ""),
                PartnerItem(name: "ママ", profileImage: "", message: ""),
                PartnerItem(name: "息子ちゃん", profileImage: "", message: "")
            ],
            onAddedPartner: {}
        )
    }
}
