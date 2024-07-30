import SwiftUI
import PDFKit
import MessageUI
import UniformTypeIdentifiers

struct QRCodeView: View {
    let event: Event
    @State private var showingMailComposer = false
    @State private var showingDocumentPicker = false

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    var body: some View {
        let qrCodeImage = QRCodeGenerator().generateQRCode(from: "\(event.name)\n\(event.organizerName)\n\(event.start) - \(event.end)\n\(dateFormatter.string(from: event.date))\n\(event.description)")
        
        VStack {
            Image(uiImage: qrCodeImage)
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: 200, height: 200)
            Text(event.name)
                .font(.headline)
            Text(event.description)
                .font(.subheadline)
            Spacer()
            HStack {
                Button(action: {
                    showingDocumentPicker.toggle()
                }) {
                    Text("Save as PDF")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.leading)
                .padding(.bottom)

                Button(action: {
                    showingMailComposer.toggle()
                }) {
                    Text("Send as Email")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.trailing)
                .padding(.bottom)
            }
        }
        .padding()
        .sheet(isPresented: $showingMailComposer) {
            if let pdfData = createPDF(from: qrCodeImage, event: event) {
                MailView(data: pdfData, event: event)
            }
        }
        .sheet(isPresented: $showingDocumentPicker) {
            if let pdfData = createPDF(from: qrCodeImage, event: event) {
                DocumentPicker(data: pdfData, event: event)
            }
        }
    }

    func createPDF(from image: UIImage, event: Event) -> Data? {
        let pdfMetaData = [
            kCGPDFContextCreator: "MyApp",
            kCGPDFContextAuthor: "MyApp",
            kCGPDFContextTitle: event.name
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]

        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        let data = renderer.pdfData { (context) in
            context.beginPage()
            let qrSize = CGSize(width: 300, height: 300)  // Increase the size of the QR code here
            let qrRect = CGRect(x: (pageRect.width - qrSize.width) / 2.0, y: (pageRect.height - qrSize.height) / 2.0, width: qrSize.width, height: qrSize.height)
            image.draw(in: qrRect)
        }

        return data
    }
}

struct MailView: UIViewControllerRepresentable {
    let data: Data
    let event: Event

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.setSubject("QR Code for \(event.name)")
        vc.setMessageBody("Attached is the QR code for \(event.description).", isHTML: false)
        vc.addAttachmentData(data, mimeType: "application/pdf", fileName: "\(event.name).pdf")
        vc.mailComposeDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: MailView

        init(_ parent: MailView) {
            self.parent = parent
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }
    }
}

struct DocumentPicker: UIViewControllerRepresentable {
    let data: Data
    let event: Event

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(event.name).pdf")
        do {
            try data.write(to: tempURL)
        } catch {
            print("Failed to write PDF data to temporary file: \(error.localizedDescription)")
        }
        
        let documentPicker = UIDocumentPickerViewController(forExporting: [tempURL])
        return documentPicker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
}
