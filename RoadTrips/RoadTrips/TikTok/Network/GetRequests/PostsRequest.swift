//
//  PostsRequest.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 13/06/1443 AH.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class PostsRequest: NetworkModel {
    static let db = Firestore.firestore().collection("Post")
   
    static func getPostsByPages( success: @escaping Success, failure:  @escaping Failure){
        db.getDocuments(completion: {snapshot, error in
                if let error = error {
                    failure(error)
                } else {
                    if let snapshot = snapshot {
                        success(snapshot)
                    }
                }
            })
    }
    
    /**
     Get Post's Video with **name**
        - Parameter name: A reference name in the firebase storage (includes file type)
     */
    static func getPostsVideoURL(name: String, success: @escaping Success, failure:  @escaping Failure){
        let pathRef = Storage.storage().reference().child("Videos/\(name)")
        // MaxSize of the video is 30MB
        pathRef.downloadURL(completion: {url, error in
            if let error = error {
                failure(error)
            } else {
                guard let url = url else {
                    print("Unable to get video url: \(name)")
                    return
                }
                success(url)
            }
        })
    }
}
