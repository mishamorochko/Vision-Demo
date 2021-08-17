import UIKit

final class ImagePickerRouter: UIViewController {

    private var selectedImage: ((UIImage) -> Void)?

    func showCamera(on view: UIViewController, selectedImageCompletion: @escaping ((UIImage)->Void)) {
        selectedImage = selectedImageCompletion
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            view.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            view.present(alert, animated: true, completion: nil)
        }
    }

    func showGallery(on view: UIViewController, selectedImageCompletion: @escaping ((UIImage)->Void)) {
        selectedImage = selectedImageCompletion
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .savedPhotosAlbum
            view.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            view.present(alert, animated: true, completion: nil)
        }
    }
}

extension ImagePickerRouter: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            self.selectedImage?(pickedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
