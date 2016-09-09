//
//  ViewController.swift
//  ImageLab
//
//  Created by Eric Larson
//  Copyright © 2016 Eric Larson. All rights reserved.
//

import UIKit

class ViewController: UIViewController   {

    
    var filters : [CIFilter]! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupFilters()
        
    
    }
    
    func setupFilters(){
        filters = []
        let filterBloom = CIFilter(name: "CIBloom")!
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
    

}

