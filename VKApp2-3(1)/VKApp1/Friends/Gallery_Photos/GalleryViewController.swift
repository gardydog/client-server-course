//
//  GalleryViewController.swift
//  VKApp1
//
//  Created by Mac on 06.06.2021.
//

import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var galleryView: GalleryHorisontalView!

    var galleryPhotos = [PhotoItemsCodable]()
    var selectedImageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galleryView.setImages(images: getImages(), showIndexPhoto: selectedImageIndex)
    }
    
    func getImages() -> [UIImage] {
        var images = [UIImage]()
        
        for photo in galleryPhotos {
            for photoSize in photo.sizes {
                if photoSize.type == "x" {
                    if let url = URL(string: photoSize.url) {
                        if let data = try? Data(contentsOf: url) {
                            if let image = UIImage(data: data) {
                                images.append(image)
                            }
                        }
                    }
                }
            }
        }
        
        return images
    }
    

    

        

    
}
