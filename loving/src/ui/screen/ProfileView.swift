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
        ScrollView {
            VStack() {
                Spacer().frame(height: 64)
                ProfileAccount()
                ProfileContent()
                Spacer().frame(height: 64)                
            }
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
