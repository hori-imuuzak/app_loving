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
    var action: (() -> Void)? = nil
    var destination: AnyView? = nil
    
    var body: some View {
        VStack() {
            if isFirst {
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }
            if self.action != nil {
                Button(action: self.action!) {
                    itemView
                }.buttonStyle(BorderlessButtonStyle())
            }
            if destination != nil {
                NavigationLink(destination: self.destination) {
                    itemView
                }
            }
            Divider()
                .frame(height: 1)
                .background(Color.gray)
        }
    }
    
    private var itemView: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(self.label)
                        .foregroundColor(Color.black)
                    if !hint.isEmpty {
                        Text(self.hint)
                            .font(.system(size: Const.FontSize.S))
                            .foregroundColor(Color.gray)
                            .padding(.top, Const.Padding.S)
                    }
                }
                Spacer()
                Text(self.text)
                .foregroundColor(Color.black)
            }
            .padding(.vertical, Const.Padding.M)
            .padding(.horizontal, Const.Padding.L)
            .frame(maxWidth: .infinity)
        }
    }
}

#if DEBUG
struct ProfileItemRow_Preview: PreviewProvider {
    static var previews: some View {
        ProfileItemRow(label: "PartnerID", hint: "fugafuga", text: "hogehoge", isFirst: true, destination: AnyView(Text("Hoge")))
    }
}
#endif
