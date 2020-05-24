//
//  ProfileAccount.swift
//  loving
//
//  Created by 堀知海 on 2020/05/20.
//  Copyright © 2020 umiapp. All rights reserved.
//

import Foundation
import SwiftUI
import URLImage

struct ProfileAccount: View {
    var name: String
    var profileImageUrl: String
    var coverImageUrl: String
    
    var body: some View {
        ZStack(alignment: .center) {
            Background(coverImageUrl: self.coverImageUrl)
            Account(name: self.name, profileImageUrl: self.profileImageUrl)
        }
    }
}
    
struct Background: View {
    var coverImageUrl: String
    
    var body: some View {
        VStack() {
            URLImage(URL(string: self.coverImageUrl)!, placeholder: Image("profile_bg").resizable())
            }.frame(maxWidth: .infinity, maxHeight: 180, alignment: .center)
    }
}

struct Account: View {
    var name: String
    var profileImageUrl: String
    
    var body: some View {
        VStack(alignment: .center) {
            HStack() {
                Button(action: {}) {
                    VStack(alignment: .center) {
                        URLImage(URL(string: self.profileImageUrl)!, placeholder: Image("profile_default"))
                                .clipShape(Circle())
                                .frame(width: 32, height: 32)
                        }
                        .foregroundColor(Color.white)
                        .frame(width: 64, height: 64)
                        .overlay(Circle().stroke(Color.white, lineWidth: 1))
                }
                VStack(alignment: .leading) {
                    Text(self.name)
                        .fontWeight(.heavy)
                        .lineLimit(1)
                        .foregroundColor(Color.white)
                    Button(action: {}) {
                        Text("名前を変更する")
                            .font(.system(size: Const.FontSize.S))
                            .foregroundColor(Color.white)
                    }.padding(.top, Const.Padding.S)
                }
            }
        }
    }
}

#if DEBUG
struct ProfileAccount_Preview: PreviewProvider {
    static var previews: some View {
        ProfileAccount(name: "ほげ太郎", profileImageUrl: "http://placeimg.com/350/250/people", coverImageUrl: "https://i.picsum.photos/id/1041/350/250.jpg")
    }
}
#endif
