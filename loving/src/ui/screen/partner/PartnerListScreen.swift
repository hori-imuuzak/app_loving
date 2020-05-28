//
//  PartnerListView.swift
//  loving
//
//  Created by 堀知海 on 2020/05/28.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI
import RxSwift

struct PartnerListScreen: View {
    
    private let viewModel = PartnerViewModel(partnerRepository: FirebasePartnerRepository.instance)
    private let disposeBag = DisposeBag()
    
    @State var partnerList: Array<Partner> = []
    
    var body: some View {
        PartnerList(partners: self.partnerListToPartnerItemList())
        .onAppear() {
            self.viewModel.inputs.getPartnerList()
            self.observe()
        }
    }
    
    private func partnerListToPartnerItemList() -> Array<PartnerItem> {
        return self.partnerList.map { partner in
            PartnerItem(
                name: partner.name,
                profileImage: partner.profileImageUrl,
                message: partner.comment // TODO メッセージに後で変更する
            )
        }
    }
    
    private func observe() {
        self.viewModel.outputs.partners.subscribe(onNext: { partners in
            self.partnerList = partners
        }).disposed(by: disposeBag)
    }
}

struct PartnerListScreen_Previews: PreviewProvider {
    static var previews: some View {
        PartnerListScreen()
    }
}