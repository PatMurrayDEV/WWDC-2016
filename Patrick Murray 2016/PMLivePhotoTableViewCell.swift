//
//  PMLivePhotoTableViewCell.swift
//  Patrick Murray 2016
//
//  Created by Patrick Murray on 30/04/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit

import Photos
import PhotosUI

class PMLivePhotoTableViewCell: UITableViewCell {
    
    private let maxForceValue: CGFloat = 6.6 - 1
    
    var placeholderImage: UIImage? = nil
    var imageURL: NSURL? = nil
    var videoURL: NSURL? = nil
    
    @IBOutlet weak var badgeImageView: UIImageView!
    
    @IBOutlet weak var liveView: PHLivePhotoView!
    @IBOutlet weak var heightContrainst: NSLayoutConstraint!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        liveView.layer.cornerRadius = 20.0
        liveView.clipsToBounds = true
        
        let gesture = ForceGestureRecognizer()
        gesture.addTarget(self, action: #selector(PMMapTableViewCell.backgroundPressed(_:)))
        liveView.addGestureRecognizer(gesture)
        

        let badge = PHLivePhotoView.livePhotoBadgeImageWithOptions(.OverContent)
        badgeImageView.image = badge

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareLivePhoto() {
        makeLivePhotoFromItems { (livePhoto) in
            self.liveView.livePhoto = livePhoto
            self.liveView.startPlaybackWithStyle(.Hint)
        }
    }
    
    
    private func makeLivePhotoFromItems(completion: (PHLivePhoto) -> Void) {
        PHLivePhoto.requestLivePhotoWithResourceFileURLs([imageURL!, videoURL!], placeholderImage: placeholderImage, targetSize: CGSizeZero, contentMode: .AspectFit) {
            (livePhoto, infoDict) -> Void in
            // This "canceled" condition is just to avoid redundant passes in the Playground preview panel.
            if let canceled = infoDict[PHLivePhotoInfoCancelledKey] as? Int where canceled == 0 {
                if let livePhoto = livePhoto {
                    completion(livePhoto)
                }
            }
        }
    }
    
    func backgroundPressed(sender: ForceGestureRecognizer) {

        if sender.state == .Ended {
            self.liveView.stopPlayback()
            return
        }

        if sender.forceValue > 1 {
            self.liveView.startPlaybackWithStyle(.Full)
        } else {
            self.liveView.startPlaybackWithStyle(.Hint)
        }
        
    }


}
