//
//  UidQrGenerate.swift
//  loving
//
//  Created by 堀知海 on 2020/05/28.
//  Copyright © 2020 umiapp. All rights reserved.
//

import SwiftUI
import CoreImage

struct UidQrGenerate: View {
    var uid: String

    @State private var qrImage: UIImage? = nil
    
    var body: some View {
        VStack {
            Text("相手にQRコードを読み取ってもらうことでお互いがパートナーに追加されます。").padding(.bottom, Const.Padding.M)
            if qrImage == nil {
                Text("Loading")
            } else {
                Image(uiImage: self.qrImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 128, height: 128)
            }
        }
        .padding(Const.Padding.L)
        .onAppear() {
            let uidData = self.uid.data(using: .utf8)
            guard let data = uidData else { return }

            let sizeTransform = CGAffineTransform(scaleX: 10, y: 10)

            let qr = CIFilter(name: "CIQRCodeGenerator", parameters: ["inputMessage": data, "inputCorrectionLevel": "M"])
            if let qrImage = qr?.outputImage?.transformed(by: sizeTransform) {
                guard let cgImage = CIContext().createCGImage(qrImage, from: qrImage.extent) else { return }
                self.qrImage = UIImage(cgImage: cgImage)
            }
        }
    }
}

struct UidQrGenerate_Previews: PreviewProvider {
    static var previews: some View {
        UidQrGenerate(uid: "hogehoge_this_is_user_id")
    }
}
