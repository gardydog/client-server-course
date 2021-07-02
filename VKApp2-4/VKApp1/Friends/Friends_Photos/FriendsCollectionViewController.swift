//
//  FriendsCollectionViewController.swift
//  VKApp1
//
//  Created by Mac on 22.05.2021.
//

import UIKit

class FriendsCollectionViewController: UICollectionViewController {
    
    var photos = [PhotoItemsCodable]()
    var friendId: Int = 0
    
    let networkservice = NetworkService()
    
    let FriendsCollectionViewCell = "FriendsCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPhotosBy(userId: friendId)
    }
    
    func setPhotosBy(userId: Int) {
        networkservice.loadFriendsPhotos(by: userId) { photos in
            self.photos = photos
            self.collectionView.reloadData()
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsCollectionViewCell, for: indexPath) as? FriendsCollectionViewCell
        else { return UICollectionViewCell() }
    
        let image = photos[indexPath.item]
        cell.configure(photoImage: image)
    
        return cell
    }
    
    //MARK: - Метод добавляет коллекцию фото пользователя в галлерею -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard
        segue.identifier == "fromCollectionToGallery",
        let photoGallery = segue.destination as? GalleryViewController,
        let indexPath = collectionView.indexPathsForSelectedItems?.first
       else { return }

        photoGallery.galleryPhotos = photos     //Передаю в место, в котором будет галерея фоток, массив всех фотографий
        photoGallery.selectedImageIndex = indexPath.item

    }
    
}
