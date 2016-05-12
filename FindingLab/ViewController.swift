//
//  ViewController.swift
//  FindingLab
//
//  Created by Bishal Gautam on 5/8/16.
//  Copyright © 2016 Bishal Gautam. All rights reserved.
//

import UIKit
import AssetsLibrary
import CoreLocation
import Photos
import AVFoundation

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
   // var library : ALAssetsLibrary = ALAssetsLibrary()
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
       // vc.sourceType = UIImagePickerControllerSourceType.Camera
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary

        
        self.presentViewController(vc, animated: true, completion: nil)
        
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: { () in
            if (picker.sourceType == .PhotoLibrary) {
                let image = info[UIImagePickerControllerOriginalImage] as! UIImage
                 let library = ALAssetsLibrary()
               // let library = PHPhotoLibrary()

                var url: NSURL = info[UIImagePickerControllerReferenceURL] as! NSURL
                
                library.assetForURL(url, resultBlock: { (asset: ALAsset!) in
                    if asset.valueForProperty(ALAssetPropertyLocation) != nil {
                        let latitude = (asset.valueForProperty(ALAssetPropertyLocation) as! CLLocation!).coordinate.latitude
                        let longitude = (asset.valueForProperty(ALAssetPropertyLocation) as! CLLocation!).coordinate.longitude
                        print("\(latitude), \(longitude)")
                    }
                    },
                    failureBlock: { (error: NSError!) in
                        print(error.localizedDescription)
                })
            }
        })
//        // Get the image captured by the UIImagePickerController
//        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
//        
//        // Do something with the images (based on your use case)
//        
//
//        
//        // Dismiss UIImagePickerController to go back to your original view controller
//         dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func scaleImage(image: UIImage, maxDimension: CGFloat) -> UIImage {
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        var scaleFactor: CGFloat
        
        if image.size.width > image.size.height {
            scaleFactor = image.size.height / image.size.width
            scaledSize.width = maxDimension
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            scaleFactor = image.size.width / image.size.height
            scaledSize.height = maxDimension
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        image.drawInRect(CGRectMake(0, 0, scaledSize.width, scaledSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    
    public class LoadingOverlay{
        
        var overlayView = UIView()
        var activityIndicator = UIActivityIndicatorView()
        
        class var shared: LoadingOverlay {
            struct Static {
                static let instance: LoadingOverlay = LoadingOverlay()
            }
            return Static.instance
        }
        
        public func showOverlay(view: UIView) {
            if  let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate,
                let window = appDelegate.window {
                overlayView.frame = CGRectMake(0, 0, 120, 120)
                overlayView.center = CGPointMake(window.frame.width / 2.0, window.frame.height / 2.0)
                overlayView.backgroundColor = UIColor(hue: 0.0083, saturation: 1, brightness: 0.5, alpha: 1.0)
                overlayView.clipsToBounds = true
                overlayView.layer.cornerRadius = 10
                
                activityIndicator.frame = CGRectMake(0, 0, 80, 80)
                activityIndicator.activityIndicatorViewStyle = .WhiteLarge
                activityIndicator.center = CGPointMake(overlayView.bounds.width / 2, overlayView.bounds.height / 2)
                
                overlayView.addSubview(activityIndicator)
                window.addSubview(overlayView)
                
                activityIndicator.startAnimating()
            }
        }
        
        public func hideOverlayView() {
            
            activityIndicator.stopAnimating()
            overlayView.removeFromSuperview()
        }
    }

}

