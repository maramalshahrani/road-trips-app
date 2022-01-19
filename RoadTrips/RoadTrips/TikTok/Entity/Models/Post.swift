//
//  Post.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 13/06/1443 AH.
//

import Foundation
import UIKit
import AVFoundation

struct Post: Codable{
    var id: String
    var video: String
    var videoURL: String?
    var videoFileExtension: String?
    var videoHeight: Int
    var videoWidth: Int
    var caption: String
    var likeCount: Int
    var shareCount: Int
    var commentID: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case video
        case videoURL
        case videoFileExtension
        case videoHeight
        case videoWidth
        case caption
        case likeCount
        case shareCount
        case commentID
    }
    
    init(id: String, video: String, videoURL: String? = nil, videoFileExtension: String? = nil, videoHeight: Int, videoWidth: Int, caption: String,  likeCount: Int, shareCount: Int, commentID: String) {
        self.id = id
        self.video = video
        self.videoURL = videoURL ?? ""
        self.videoFileExtension = videoFileExtension ?? "mp4"
        self.videoHeight = videoHeight
        self.videoWidth = videoWidth
        self.caption = caption
        self.likeCount = likeCount
        self.shareCount = shareCount
        self.commentID = commentID
    }
    
    init(dictionary: [String: Any]) {
        id = dictionary["id"] as? String ?? ""
        video = dictionary["video"] as? String ?? ""
        videoURL = dictionary["videoURL"] as? String ?? ""
        videoFileExtension = dictionary["videoFileExtension"] as? String ?? ""
        videoHeight = dictionary["videoHeight"] as? Int ?? 0
        videoWidth = dictionary["videoWidth"] as? Int ?? 0
        caption = dictionary["caption"] as? String ?? ""
        likeCount = dictionary["likeCount"] as? Int ?? 0
        shareCount = dictionary["shareCount"] as? Int ?? 0
        commentID = dictionary["commentID"] as? String ?? ""
    }

    
    var dictionary: [String: Any] {
        let data = (try? JSONEncoder().encode(self)) ?? Data()
        return (try? JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .allowFragments]) as? [String: Any]) ?? [:]
    }
    
}


