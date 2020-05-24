//
//  ProfileView.swift
//  loving
//
//  Created by 堀知海 on 2020/05/19.
//  Copyright © 2020 umiapp. All rights reserved.
//

import Foundation
import SwiftUI
import URLImage

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ProfileAccount()
                    ProfileContent()
                    Spacer().frame(height: 160)
                }
            }
            .navigationBarTitle(Text("設定"))
        }
    }
}

#if DEBUG
struct ProfileView_Preview: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
#endif
