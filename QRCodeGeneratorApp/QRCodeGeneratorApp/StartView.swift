import SwiftUI

struct StartView: View {
    @State private var scannedCode: String?

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ContentView()) {
                    Text("QR Code Generator")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()

                NavigationLink(destination: QRCodeScannerView(didFindCode: handleFoundCode)) {
                    Text("QR Code Scanner")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()

                if let scannedCode = scannedCode {
                    Text("Scanned QR Code: \(scannedCode)")
                        .padding()
                }
            }
        }
    }

    func handleFoundCode(_ code: String) {
        scannedCode = code
    }
}
