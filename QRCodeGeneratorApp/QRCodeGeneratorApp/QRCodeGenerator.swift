import UIKit
import CoreImage

public class QRCodeGenerator {
    public init() {}

    public func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = filter.outputImage?.transformed(by: transform) {
                // Verwende UIImage(ciImage:) für die Umwandlung
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
}
