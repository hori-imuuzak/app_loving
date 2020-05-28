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
    
    var onSaveName: (_: String) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Background(coverImageUrl: self.coverImageUrl, width: geometry.size.width)
                Account(name: self.name, profileImageUrl: self.profileImageUrl, onSaveName: self.onSaveName)
            }
        }.frame(height: 180)
    }
}
    
struct Background: View {
    var coverImageUrl: String
    var width: CGFloat
    
    var body: some View {
        VStack() {
            if self.coverImageUrl.isEmpty {
                Image("default_cover").resizable().scaledToFill()
            } else {
                URLImage(URL(string: self.coverImageUrl)!, placeholder: Image("default_cover").resizable()).scaledToFill()
            }
        }
        .frame(width: self.width, height: 180, alignment: .center)
        .clipped()
    }
}

struct Account: View {
    var name: String
    var profileImageUrl: String
    
    var onSaveName: (_: String) -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            HStack() {
                Button(action: {}) {
                    VStack(alignment: .center) {
                        if self.profileImageUrl.isEmpty {
                            Image("default_user")
                                .foregroundColor(Color.white)
                                .frame(width: 64, height: 64)
                        } else {
                            URLImage(URL(string: self.profileImageUrl)!, placeholder: Image("default_user")) { proxy in
                                    proxy.image
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .clipped()
                                        .frame(width: 64, height: 64)
                                }
                                .overlay(Circle().stroke(Color.white, lineWidth: 1))
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                VStack(alignment: .leading) {
                    Text(self.name)
                        .fontWeight(.heavy)
                        .lineLimit(1)
                        .foregroundColor(Color.white)
                        .shadow(color: Color.black, radius: Const.Shadow, x: 0, y: 0)
                    NavigationLink(destination: EditNameScreen(onSaveName: self.onSaveName)) {
                        Text("名前を変更する")
                            .font(.system(size: Const.FontSize.S))
                            .foregroundColor(Color.white)
                            .shadow(color: Color.black, radius: Const.Shadow, x: 0, y: 0)
                    }.padding(.top, Const.Padding.S)
                }
            }
        }
    }
}

#if DEBUG
struct ProfileAccount_Preview: PreviewProvider {
    static var previews: some View {
        ProfileAccount(name: "ほげ太郎", profileImageUrl: "http://placeimg.com/350/250/people", coverImageUrl: "https://i.picsum.photos/id/1041/350/250.jpg", onSaveName: { _ in })
    }
}
#endif
