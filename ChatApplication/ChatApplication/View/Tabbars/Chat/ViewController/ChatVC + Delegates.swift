//
//  Untitled.swift
//  ChatApplication
//
//  Created by NAM on 04/10/24.
//

import Foundation
import UIKit
import Lightbox
import AVFoundation
import AVKit


extension ChatVC: MessageDelegate, UIDocumentInteractionControllerDelegate {
    func openPdfViewController(message: RealmMessage) {
        let dc = UIDocumentInteractionController(url: URL(fileURLWithPath:  message.getDocumentPathUrl(isThumbnail: false).path))
            dc.delegate = self
            dc.presentPreview(animated: true)
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self//or use return self.navigationController for fetching app navigation bar colour
    }
    
    func actionOnViewMedia(message: RealmMessage) {
        if MessageType.IMAGE.rawValue == message.messageType {
                var images = [LightboxImage]()
                var imageUrls = [String]()
            if FileManager.default.fileExists(atPath: message.getImagePathUrl.path) {
                let imageData = NSData(contentsOf: message.getImagePathUrl)
                images.append(LightboxImage(
                    image: UIImage(data: imageData as? Data ?? Data()) ?? UIImage(),
                    text: message.message ?? ""
                ))
                imageUrls.append(message.getImagePathUrl.path)
                
            }
            
            let lightBoxVC = LightboxController(images: images.reversed(), startIndex: 0)
            lightBoxVC.modalPresentationStyle = .fullScreen
            lightBoxVC.dynamicBackground = true
            present(lightBoxVC, animated: true, completion: nil)
            
        } else if MessageType.VIDEO.rawValue == message.messageType {
            let player = AVPlayer(url: message.getVideoPathUrl(isThumbnail: false) as URL)
            DispatchQueue.main.async {
                let playerController = AVPlayerViewController()
                playerController.showsPlaybackControls = true
                playerController.allowsPictureInPicturePlayback = false
                playerController.player = player
                playerController.entersFullScreenWhenPlaybackBegins = true
                playerController.exitsFullScreenWhenPlaybackEnds = true
                self.present(playerController, animated: false) {
                    playerController.player?.play()
                }
            }
        }
    }
     
}
