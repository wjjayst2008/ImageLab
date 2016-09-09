//
//  ViewController.swift
//  ImageLab
//
//  Created by Eric Larson
//  Copyright © 2016 Eric Larson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var imageView: UIImageView!
    var filter : CIFilter! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlPath = NSBundle.mainBundle().pathForResource("smu-campus", ofType: "jpg")
        let fileURL = NSURL.fileURLWithPath(urlPath!)
        
        let beginImage = CIImage(contentsOfURL: fileURL)
        
        filter = CIFilter(name: "CIBloom")!
        filter.setValue(beginImage, forKey: kCIInputImageKey)
        filter.setValue(0.5, forKey: kCIInputIntensityKey)
        filter.setValue(20, forKey: "inputRadius")
        
        let newImage = UIImage(CIImage: filter.outputImage!)
        self.imageView.image = newImage
    
    }
    
    
    @IBAction func loadImage(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        self.presentViewController(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        let image = info["UIImagePickerControllerOriginalImage"] as! UIImage
        let beginImage = CIImage(image: image)
        filter.setValue(beginImage, forKey: kCIInputImageKey)
        let newImage = UIImage(CIImage: filter.outputImage!, scale: CGFloat(1.0), orientation: image.imageOrientation)
        self.imageView.image = newImage
        
    }

}

