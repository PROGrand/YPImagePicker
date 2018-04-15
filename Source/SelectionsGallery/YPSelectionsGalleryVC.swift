//
//  SelectionsGalleryVC.swift
//  YPImagePicker
//
//  Created by Nik Kov || nik-kov.com on 09.04.18.
//  Copyright © 2018 Yummypets. All rights reserved.
//

import UIKit

// TODO: Add paging to collection view

public class YPSelectionsGalleryVC: UIViewController {
    
    /// Designated initializer
    class func initWith(items: [YPMediaItem],
                        imagePicker: YPImagePicker,
                        configuration: YPImagePickerConfiguration) -> YPSelectionsGalleryVC {
        let vc = YPSelectionsGalleryVC(nibName: "YPSelectionsGalleryVC", bundle: Bundle(for: YPSelectionsGalleryVC.self))
        vc.items = items
        vc.imagePicker = imagePicker
        vc.configuration = configuration
        return vc
    }

    @IBOutlet weak var collectionV: UICollectionView!

    public var items: [YPMediaItem] = []
    public var imagePicker: YPImagePicker!
    public var configuration: YPImagePickerConfiguration!

    override public func viewDidLoad() {
        super.viewDidLoad()

        // Register collection view cell
        let bundle = Bundle(for: YPSelectionsGalleryVC.self)
        collectionV.register(UINib(nibName: "YPSelectionsGalleryCVCell", bundle: bundle), forCellWithReuseIdentifier: "item")
        
        // Install right bar button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: configuration.wordings.next,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(done))
    }

    @objc private func done() {
        configuration.delegate?.imagePicker(imagePicker, didSelect: items)
    }
}

// MARK: - Collection View
extension YPSelectionsGalleryVC: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! YPSelectionsGalleryCVCell
        
        let item = items[indexPath.row]
        switch item.type {
        case .photo:
            cell.imageV.image = item.photo?.image
        case .video:
            cell.imageV.image = item.video?.thumbnail
        }
        
        return cell
    }
}

extension YPSelectionsGalleryVC: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        if item.type == .photo {
            /// open image filter
        } else {
            /// open video crop
        }
    }
}

extension YPSelectionsGalleryVC: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideSize = collectionView.frame.size.height - 30
        return CGSize(width: sideSize, height: sideSize)
    }
}
