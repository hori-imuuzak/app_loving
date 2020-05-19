//
//  ProfileItemRow.swift
//  loving
//
//  Created by 堀知海 on 2020/05/20.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI

struct ProfileItemRow: View {
    var label: String = ""
    var hint: String = ""
    var text: String = ""
    var isFirst: Bool = false
    
    var body: some View {
        VStack() {
            if isFirst {
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }
            Button(action: {}) {
                VStack() {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            Text(self.label)
                                .foregroundColor(Color.black)
                            if !hint.isEmpty {
                                Text(self.hint)
                                    .font(.system(size: 12))
                                    .foregroundColor(Color.gray)
                                    .padding(.top, 4)
                            }
                        }
                        Spacer()
                        Text(self.text)
                        .foregroundColor(Color.black)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity)
                }
            }
            Divider()
                .frame(height: 1)
                .background(Color.gray)
        }
    }
}

#if DEBUG
struct ProfileItemRow_Preview: PreviewProvider {
    static var previews: some View {
        ProfileItemRow(label: "PartnerID", hint: "fugafuga", text: "hogehoge", isFirst: true)
    }
}
#endif
