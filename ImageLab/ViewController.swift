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
    var filters : [CIFilter]! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlPath = NSBundle.mainBundle().pathForResource("smu-campus", ofType: "jpg")
        let fileURL = NSURL.fileURLWithPath(urlPath!)
        
        let beginImage = CIImage(contentsOfURL: fileURL)
        
        self.setupFilters()
        
        let newImage = UIImage(CIImage: applyFilters(beginImage!))
        self.imageView.image = newImage
    
    }
    
    func setupFilters(){
        filters = []
        let filterBloom = CIFilter(name: "CIBloom")!
        //filterBloom.setValue(beginImage, forKey: kCIInputImageKey)
        filterBloom.setValue(0.5, forKey: kCIInputIntensityKey)
        filterBloom.setValue(20, forKey: "inputRadius")
        filters.append(filterBloom)
        
        let filterHue = CIFilter(name:"CIHueAdjust")!
        filterHue.setValue(10.0, forKey: "inputAngle")
        filters.append(filterHue)
    }
    
    func applyFilters(inputImage:CIImage)->CIImage{
        var retImage = inputImage
        for filt in filters{
            filt.setValue(retImage, forKey: kCIInputImageKey)
            retImage = filt.outputImage!
        }
        return retImage
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
        let newImage = UIImage(CIImage: applyFilters(beginImage!), scale: CGFloat(1.0), orientation: image.imageOrientation)
        self.imageView.image = newImage
        
    }

}

