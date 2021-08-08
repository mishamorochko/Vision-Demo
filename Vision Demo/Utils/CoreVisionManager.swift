import Vision
import UIKit

final class CoreVisionManager {
    
    static let instance = CoreVisionManager()

    func recognizeTextFrom(image: UIImage, recognitionLevel: VNRequestTextRecognitionLevel? = nil, completion: @escaping (String) -> Void) {
        DispatchQueue.main.async {
            guard let cgImage = image.cgImage else { return }
            let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            let request = VNRecognizeTextRequest { request, _ in
                guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
                let recognizedStrings = observations.compactMap { observation in
                    observation.topCandidates(1).first?.string
                }
                var recognizedString = ""
                recognizedStrings.forEach { string in
                    recognizedString += "\(string) "
                }
                completion(recognizedString.isEmpty ? "Text not found" : recognizedString)
            }
            request.recognitionLevel = recognitionLevel ?? .accurate
            request.usesLanguageCorrection = true
            do {
                try requestHandler.perform([request])
            } catch {
                print("Unable to perform the requests: \(error).")
            }
        }
    }
}
