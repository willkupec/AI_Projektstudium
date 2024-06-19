import SwiftUI

struct QRCodeView: View {
    let event: Event

    var body: some View {
        VStack {
            if let qrCodeImage = QRCodeGenerator.generateQRCode(from: "\(event.name)\n\(event.time)\n\(event.date)") {
                Image(uiImage: qrCodeImage)
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 200, height: 200)
            } else {
                Text("Failed to generate QR Code")
            }
        }
        .padding()
    }
}
