//
//  FirebaseStorageManager.swift
//  Petmily
//
//  Created by t2023-m0056 on 2023/08/20.
//

import UIKit
import FirebaseStorage
import Firebase
import AVFoundation

class FirebaseStorageManager {
    static func uploadImage(image: UIImage, pathRoot: String, completion: @escaping (URL?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        let imageName = UUID().uuidString + String(Date().timeIntervalSince1970)
        
        let firebaseReference = Storage.storage().reference().child("\(imageName)")
        firebaseReference.putData(imageData, metadata: metaData) { metaData, error in
            firebaseReference.downloadURL { url, _ in
                completion(url)
                print("요기요 \(completion(url))")
            }
        }
    }
    
    static func downloadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        let storageReference = Storage.storage().reference(forURL: urlString)
        let megaByte = Int64(1 * 1024 * 1024)
        
        storageReference.getData(maxSize: megaByte) { data, error in
            guard let imageData = data else {
                completion(nil)
                return
            }
            completion(UIImage(data: imageData))
        }
    }
    
    static func uploadVideo(file: URL, completion: @escaping (URL?) -> Void) {
        let videoName = "\(UUID().uuidString + String(Date().timeIntervalSince1970))"
        do {
            let data = try Data(contentsOf: file)
            
            let storageRef =
        Storage.storage().reference().child("\(videoName)")
            if let uploadData = data as Data? {
                let metaData = StorageMetadata()
                metaData.contentType = "video/mp4"
                storageRef.putData(uploadData, metadata: metaData
                                   , completion: { (metadata, error) in
                                    if let error = error {
//                                        completion(nil, error.localizedDescription)
                                    }else{
                                        storageRef.downloadURL { (url, error) in
                                            guard let downloadURL = url else {
//                                                completion(url)
                                                return
                                            }
                                            completion(url)
                                        }
                                    }
                                   })
            }
        }catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    static func downloadVideo(urlString: String, completion: @escaping (URL?) -> Void) {
        let storageReference = Storage.storage().reference(forURL: urlString)
//        let megaByte = Int64(1 * 1024 * 1024)
        
        storageReference.downloadURL { (url, error) in
                            if let error = error {
                                print("DEBUG: Upload: \(error.localizedDescription)")
                                return
                            }
//                            guard let videoUrl = url?.absoluteString else {
//                                print("DEBUG: Upload failed get URL")
//                                return
//                            }
                            completion(url)
                        }
        
    }
}
