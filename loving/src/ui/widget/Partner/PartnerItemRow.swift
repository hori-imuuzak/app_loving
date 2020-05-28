//
//  PartnerItemRow.swift
//  loving
//
//  Created by 堀知海 on 2020/05/21.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI
import URLImage
import FirebaseStorage

struct PartnerItem: Identifiable {
    let id = UUID()
    let name: String
    let profileImage: String
    let message: String
}

struct PartnerItemRow: View {
    @State private var imageUrl: URL? = nil

    var name: String
    var profileImage: String
    var message: String = ""
    
    var body: some View {
        VStack() {
            Button(action: {}) {
                HStack() {
                    if self.imageUrl == nil {
                        Image("default_user")
                            .resizable()
                            .frame(width: 32, height: 32, alignment: .center)
                    } else {
                        URLImage(self.imageUrl!, placeholder: Image("default_user").resizable()) { proxy in
                            proxy.image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .clipped()
                        }
                        .frame(width: 32, height: 32, alignment: .center)
                    }
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
            .buttonStyle(PlainButtonStyle())
            .padding(Const.Padding.L)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: Const.CornerRadius))
        .shadow(color: Color.gray, radius: Const.Shadow)
        .onAppear() {
            self.loadImage(path: self.profileImage)
        }
    }
    
    private func loadImage(path: String) {
        Storage.storage().reference(withPath: path).downloadURL { url, err in
            if err != nil { return }
            
            if let url = url?.absoluteURL {
                self.imageUrl = url
            }
        }
    }
}

#if DEBUG
struct PartnerItemRow_Preview: PreviewProvider {
    static var previews: some View {
        VStack() {
            PartnerItemRow(name: "旦那さん", profileImage: "")
            Divider().padding(.top, 16)
            PartnerItemRow(name: "旦那さん", profileImage: "", message: "新着のメッセージがあります")
        }
    }
}
#endif
