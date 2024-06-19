import SwiftUI

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var qrCodeImage: UIImage?

    let qrCodeGenerator = QRCodeGenerator()

    var body: some View {
        VStack {
            TextField("Enter text", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if let qrCodeImage = qrCodeImage {
                ImageViewWrapper(image: qrCodeImage)
                    .frame(width: 200, height: 200)
                    .background(Color.white)
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 200, height: 200)
            }

            Button(action: generateQRCode) {
                Text("Generate QR Code")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }

    func generateQRCode() {
        qrCodeImage = qrCodeGenerator.generateQRCode(from: inputText)
    }
}
