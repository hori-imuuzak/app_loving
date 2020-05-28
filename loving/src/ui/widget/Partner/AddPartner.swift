//
//  AddPartner.swift
//  loving
//
//  Created by 堀知海 on 2020/05/22.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI
import CodeScanner

struct AddPartner: View {
    let addPartner: () -> Void
    @State private var inputPartnerId = ""
    @State private var isFoundPartner = false
    
    var body: some View {
        VStack {
            if inputPartnerId.isEmpty {
                CodeScannerView(
                    codeTypes: [.qr],
                    simulatedData: "hogehoge_test_data_uid",
                    completion: self.handleScan
                )
            }
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
    
    private func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 1 else { return }
            
            self.inputPartnerId = details[0]
            // mock
            self.isFoundPartner = true
        case .failure(let err):
            print("qr scan error: \(err.localizedDescription)")
        }
    }
}

struct AddPartner_Previews: PreviewProvider {
    static var previews: some View {
        AddPartner(addPartner: {})
    }
}
