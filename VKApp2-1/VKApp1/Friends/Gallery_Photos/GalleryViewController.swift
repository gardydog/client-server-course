//
//  GalleryViewController.swift
//  VKApp1
//
//  Created by Mac on 06.06.2021.
//

import UIKit

class GalleryViewController: UIViewController {

    var galleryPhotos = [UIImage?]()
    var selectedImageIndex = 0
    
    @IBOutlet weak var galleryView: GalleryHorisontalView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let images = galleryPhotos
        galleryView.setImages(images: images)
       
    }
    

    

        

    
}
