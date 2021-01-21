/**
 
 Photo Effects
 
 by XScoder 2021
 All Rights reserved
 
 RE-SELLING THIS SOURCE CODE TO ANY ONLINE MARKETPLACE IS A SERIOUS COPYRIGHT INFRINGEMENT.
 YOU WILL BE LEGALLY PROSECUTED
 
**/

import UIKit
import CoreImage

// Array of CI Effects
let CIFilterNames = [
    "CIPhotoEffectChrome",
    "CIPhotoEffectFade",
    "CIPhotoEffectInstant",
    "CIPhotoEffectNoir",
    "CIPhotoEffectProcess",
    "CIPhotoEffectTonal",
    "CIPhotoEffectTransfer",
    "CISepiaTone"
]


class FiltersEditor: UIViewController {
    
    // VIEWS //
    @IBOutlet weak var originalImage: UIImageView!
    @IBOutlet weak var imageToFilter: UIImageView!
    @IBOutlet weak var filtersScrollView: UIScrollView!
    
    
    // VARIABLES //
    var passedImage = UIImage()
    
    

    
    // ------------------------------------------------
    // MARK: - VIEW DID LOAD
    // ------------------------------------------------
    override func viewDidLoad() {
            super.viewDidLoad()
        
        // Set the image passed from the Intro controller
        originalImage.image = passedImage
        imageToFilter.image = passedImage

        
        // Variables for setting the Font Buttons
        var X: CGFloat = 5
        let Y: CGFloat = 5
        let W: CGFloat = 70
        let H: CGFloat = 70
        let G: CGFloat = 5
        var counter = 0
        
        // Loop to create Filter buttons
        for i in 0..<CIFilterNames.count {
            counter = i
            
            // Initialize a Filer Button
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x: X, y: Y, width: W, height: H)
            filterButton.tag = i
            filterButton.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
            filterButton.layer.cornerRadius = 6
            filterButton.clipsToBounds = true
            filterButton.imageView?.contentMode = .scaleAspectFill
            
            
            // Create a filter for each button, based on their position
            let ciContext = CIContext(options: nil)
            let coreImage = CIImage(image: originalImage.image!)
            let filter = CIFilter(name: "\(CIFilterNames[i])" )
            filter!.setDefaults()
            filter!.setValue(coreImage, forKey: kCIInputImageKey)
            let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
            let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
            
            // Adjust fitered image's orientation (in case you've taken a picture with the Camera)
            let originalOrientation = originalImage.image?.imageOrientation
            let originalScale = originalImage.image?.scale
            
            // Assign filtered image to the button
            filterButton.setImage(UIImage(cgImage: filteredImageRef!, scale: originalScale!, orientation: originalOrientation!), for: .normal)
            
            
            // Add Buttons in the filtersScrollView
            X += W + G
            filtersScrollView.addSubview(filterButton)
            
        } // // ./ For
        
        
        // Set the content size of the filtersScrollView
        filtersScrollView.contentSize = CGSize(width: W * CGFloat(counter+2), height: H)
    }
    

    
    
    // ------------------------------------------------
    // MARK: - FILTER BUTTON ACTION
    // ------------------------------------------------
    @objc func filterButtonTapped(_ sender: UIButton) {
        let button = sender as UIButton
        
        // Apply the filteres image of the selected button to the imageToFilter UIImage instance
        imageToFilter.image = button.imageView!.image!
    }
    
    
    
    
    
    
    
    
    // ------------------------------------------------
    // MARK: - SHARE PICTURE WITH ACTIVITY CONTROLLER
    // ------------------------------------------------
    @IBAction func sharePictureButt(_ sender: AnyObject) {
        // This is the message that will show up while sharing the app on Twitter
        let messageStr  = "Sharing my cool picure with #Photo Effects"
        
        // This is the image that will get attached to the shating message
        let img = imageToFilter.image!
        
        // Prepare the iOS ActivityController
        let shareItems = [messageStr, img] as [Any]
        let vc = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        vc.excludedActivityTypes = [.print, .postToWeibo, .copyToPasteboard, .addToReadingList, .postToVimeo]
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            // iPad
            vc.modalPresentationStyle = .popover
            vc.popoverPresentationController?.sourceView = view
            vc.popoverPresentationController!.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            vc.popoverPresentationController?.permittedArrowDirections = []
            present(vc, animated: true, completion: nil)
        } else {
            // iPhone
            present(vc, animated: true, completion: nil)
        }
    }
    
    
    
    
    
    // ------------------------------------------------
    // MARK: - BACK BUTTON
    // ------------------------------------------------
    @IBAction func backButt(_ sender: Any) {
        // Dismiss this controller and go back to the previous one
        dismiss(animated: true, completion: nil)
    }
    

}// ./ end
