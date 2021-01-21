/**
 
 Photo Effects
 
 by XScoder 2021
 All Rights reserved
 
 RE-SELLING THIS SOURCE CODE TO ANY ONLINE MARKETPLACE IS A SERIOUS COPYRIGHT INFRINGEMENT.
 YOU WILL BE LEGALLY PROSECUTED
 
**/

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    // VARIABLES //
    var pickedImage = UIImage()
    
   
    
    // ------------------------------------------------
    // MARK: - VIEW DID LOAD
    // ------------------------------------------------
    override func viewDidLoad() {
            super.viewDidLoad()


    }

    
    
    
    // ------------------------------------------------
    // MARK: - TAKE A PICTURE BUTTON
    // ------------------------------------------------
    @IBAction func takePicButt(_ sender: Any) {
        // Instantiate the Camera controller
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    // ------------------------------------------------
    // MARK: - PICK FROM LIBRARY BUTTON
    // ------------------------------------------------
    @IBAction func libraryButt(_ sender: Any) {
        // Instantiate the Photo Library controller
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }


    
    
    // ------------------------------------------------
    // MARK: - IMAGE PICKER DELEGATE
    // ------------------------------------------------
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            pickedImage = image
        }
        dismiss(animated: true, completion: nil)
        
        // Prepare the Filters Editor controller
        let vc = storyboard?.instantiateViewController(withIdentifier: "FiltersEditor") as! FiltersEditor
        
        // Pass the pickedImage UIImage to the next controller
        vc.passedImage = pickedImage
        
        // Add a transition style between the 2 controllers
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        
        // Finally show the controller
        present(vc, animated: true, completion: nil)
    }
    
    
    
}// ./ end
