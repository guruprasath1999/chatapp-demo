//
//  Untitled.swift
//  ChatApplication
//
//  Created by NAM on 03/10/24.
//


import UIKit
import MobileCoreServices
import UniformTypeIdentifiers
import QuickLook

extension ChatVC:  UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate {
    
    // Image picker for capturing image
       func showImagePickerForCaptureImage() {
           if UIImagePickerController.isSourceTypeAvailable(.camera) {
               let imagePicker = UIImagePickerController()
               imagePicker.sourceType = .camera
               imagePicker.mediaTypes = [kUTTypeImage as String]
               imagePicker.delegate = self
               self.present(imagePicker, animated: true, completion: nil)
           }
       }

       // Image picker for capturing video
       func showImagePickerForCaptureVideo() {
           if UIImagePickerController.isSourceTypeAvailable(.camera) {
               let imagePicker = UIImagePickerController()
               imagePicker.sourceType = .camera
               imagePicker.mediaTypes = [kUTTypeMovie as String]
               imagePicker.delegate = self
               self.present(imagePicker, animated: true, completion: nil)
           }
       }

       // Image picker for choosing an image from the library
       func showImagePickerForChooseExistingImage() {
           if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
               let imagePicker = UIImagePickerController()
               imagePicker.sourceType = .photoLibrary
               imagePicker.mediaTypes = [kUTTypeImage as String]
               imagePicker.delegate = self
               self.present(imagePicker, animated: true, completion: nil)
           }
       }

       // Image picker for choosing a video from the library
       func showImagePickerForChooseExistingVideo() {
           if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
               let imagePicker = UIImagePickerController()
               imagePicker.sourceType = .photoLibrary
               imagePicker.mediaTypes = [kUTTypeMovie as String]
               imagePicker.delegate = self
               self.present(imagePicker, animated: true, completion: nil)
           }
       }

       // Document picker for files
       func showDocumentPicker() {
           let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf, UTType.text, UTType.image])
           documentPicker.delegate = self
           self.present(documentPicker, animated: true, completion: nil)
       }

       // Handle the result of picking media (image or video)
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let image = info[.originalImage] as? UIImage {
               LocalFileManager.sharedInstance().saveFile(data: image.pngData() ?? Data() ,
                                                          folderName: conversation.id ?? "",
                                                          
                                                          subFolderType: .images,
                                                          fileName: UUID().uuidString ,
                                                          documentType: "png") {
                   [self] errorMessage, destinationUrl,tempId,pathUrl   in
                           if let error = errorMessage {
                               print("Error Found while downloading: \(error)")
                           } else if destinationUrl != nil {
                               dataViewModel.sendMessage(messageType: .IMAGE, text: "", tempId: tempId)
                           } else {
                               print("Something went wrong while downloading file")
                           }
                   
                   
               }
           } else
           if let videoURL = info[.mediaURL] as? URL {
               guard let image = Utils.getThumbnailImage(forUrl: videoURL) else { return }
               LocalFileManager.sharedInstance().saveFile(data: image.pngData() ?? Data() ,
                                                          folderName: conversation.id ?? "",
                                                          subFolderType: .videos,
                                                          fileName: UUID().uuidString ,
                                                          pathUrl: videoURL,
                                                          documentType: "png") {
                   [self] errorMessage, destinationUrl,tempId,pathUrl   in
                           if let error = errorMessage {
                               print("Error Found while downloading: \(error)")
                           } else if destinationUrl != nil {
                               LocalFileManager.sharedInstance().copyFile(fromUrl:  pathUrl,
                                                                          folderName: conversation.id ?? "",
                                                                          subFolderType: .videos,
                                                                          fileName: tempId, filepath: destinationUrl?.absoluteString ?? "" ,

                                                                          documentType: videoURL.pathExtension) { [self] errorMessage, destinationUrl,tempId,filepath   in
                                           if let error = errorMessage {
                                               print("Error Found while downloading: \(error)")
                                           } else if destinationUrl != nil {
                                               dataViewModel.sendMessage(messageType: .VIDEO, text: "",tempId: tempId,fileType: videoURL.pathExtension)
                                           } else {
                                               print("Something went wrong while downloading file")
                                           }
                               }
                           } else {
                               print("Something went wrong while downloading file")
                           }
                   
                   
               }
               
           }
           
           picker.dismiss(animated: true, completion: nil)
       }

       // Handle cancellation of media picker
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }

       // Handle the result of picking a document
       func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
           // Handle the selected document
           let selectedURL = urls[0]
               
               let request = QLThumbnailGenerator.Request(fileAt: selectedURL , size: CGSize(width: 400, height:  200), scale: UIScreen.main.scale, representationTypes: .thumbnail)
               
               previewGenerator.generateBestRepresentation(for: request) { [self] thumbnail, error in
                   DispatchQueue.main.async { [self] in
                       if let error = error {
                           print(error.localizedDescription)
                       } else if let thumb = thumbnail {
                           LocalFileManager.sharedInstance().saveFile(data: thumb.uiImage.pngData() ?? Data() ,
                                                                      folderName: conversation.id ?? "",
                                                                      subFolderType: .documents,
                                                                      fileName: UUID().uuidString ,
                                                                      pathUrl: selectedURL,
                                                                      documentType: "png") {
                               [self] errorMessage, destinationUrl,tempId,pathUrl   in
                                       if let error = errorMessage {
                                           print("Error Found while downloading: \(error)")
                                       } else if destinationUrl != nil {
                                           LocalFileManager.sharedInstance().copyFile(fromUrl:  pathUrl,
                                                                                      folderName: conversation.id ?? "",
                                                                                      subFolderType: .documents,
                                                                                      fileName: tempId, filepath: destinationUrl?.absoluteString ?? "" ,

                                                                                      documentType: selectedURL.pathExtension) { [self] errorMessage, destinationUrl,tempId,filepath   in
                                                       if let error = errorMessage {
                                                           print("Error Found while downloading: \(error)")
                                                       } else if destinationUrl != nil {
                                                           dataViewModel.sendMessage(messageType: .DOCUMENT, text: "",tempId: tempId,fileType: selectedURL.pathExtension,docMessage: selectedURL.lastPathComponent)
                                                       } else {
                                                           print("Something went wrong while downloading file")
                                                       }
                                           }
                                       } else {
                                           print("Something went wrong while downloading file")
                                       }
                               
                               
                           }
                       }
                   }
               }
       }

       // Handle cancellation of document picker
       func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
           print("Document picker was cancelled")
       }
}
