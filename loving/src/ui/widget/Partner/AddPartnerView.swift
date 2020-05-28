//
//  AddPartner.swift
//  loving
//
//  Created by 堀知海 on 2020/05/22.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI
import CodeScanner
import RxSwift

struct AddPartnerView: View {
    var onAddedPartner: () -> Void
    @State private var inputPartnerId = ""
    @State private var foundPartner: Partner? = nil
    
    private let viewModel: PartnerViewModel = PartnerViewModel(
        accountRepository: FirebaseAccountRepository.instance,
        partnerRepository: FirebasePartnerRepository.instance
    )
    private let disposeBag = DisposeBag()
    
    var body: some View {
        VStack {
            if inputPartnerId.isEmpty {
                CodeScannerView(
                    codeTypes: [.qr],
                    simulatedData: "mT9buCJWoWMwAZB3ePVZdfv136x1",
                    completion: self.handleScan
                )
            }
            if self.inputPartnerId.isEmpty == false && self.foundPartner != nil {
                VStack {
                    PartnerItemRow(name: self.foundPartner!.name, profileImage: self.foundPartner!.profileImageUrl)
                    Button("追加する") {
                        self.observe()
                        self.viewModel.addPartner(partner: self.foundPartner!)
                    }.padding(.top, Const.Padding.M)
                    Button("もう一度読み込む") {
                        self.inputPartnerId = ""
                        self.foundPartner = nil
                    }.padding(.top, Const.Padding.M)
                }.padding(.top, Const.Padding.L)
            }
            Spacer()
        }
        .padding(.vertical, 120)
        .padding(.horizontal, Const.Padding.M)
    }
    
    private func observe() {
        self.viewModel.outputs.foundPartner.subscribe(onNext: { partner in
            self.foundPartner = partner
        }).disposed(by: self.disposeBag)
        
        self.viewModel.outputs.isSuccessAddPartner.subscribe(onNext: { isSuccess in
            if isSuccess == true {
                self.onAddedPartner()
            }
        }).disposed(by: self.disposeBag)
    }
    
    private func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 1 else { return }
            
            self.inputPartnerId = details[0]
            
            self.observe()
            self.viewModel.findPartner(uid: self.inputPartnerId)
        case .failure(let err):
            print("qr scan error: \(err.localizedDescription)")
        }
    }
}

struct AddPartnerView_Previews: PreviewProvider {
    static var previews: some View {
        AddPartnerView(onAddedPartner: {})
    }
}
