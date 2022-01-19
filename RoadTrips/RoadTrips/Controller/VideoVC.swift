//
//  VideoVC.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 13/06/1443 AH.
//

import UIKit
import ZLSwipeableViewSwift
import FirebaseDatabase
import AVKit
import AVFoundation
class VideoVC: UIViewController {
    
    var dataToCards = [VeidoItem]()
    
    var vedioIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.swipeableView = ZLSwipeableView()
        
        self.view.addSubview( self.swipeableView)
        swipeableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            swipeableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),

            swipeableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140),
            swipeableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            swipeableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
            
        ])
        self.view.backgroundColor =  UIColor.init(named: "WhiteColor")!
        self.dataToCards.removeAll()
        Database.database().reference().child("Video").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get Category value
            let value = (snapshot.value as? NSDictionary)?.allValues
            if value != nil {
                for curentAds in value!{
                    let value = (curentAds as? NSDictionary)
                    let imageUrl = value?["imge"] as? String ?? ""
                    let url = value?["url"] as? String ?? ""
                    let id = value?["id"] as? String ?? ""
                    
                    self.dataToCards.append(VeidoItem.init(id: id, url: url, imageUrl : imageUrl))
                    
                }
                //
                
               
                self.swipeableView.didStart = {view, location in
                    print("Did start swiping view at location: \(location)")
                }
                self.swipeableView.swiping = {view, location, translation in
                    print("Swiping at view location: \(location) translation: \(translation)")
                }
                self.swipeableView.didEnd = {view, location in
                    print("Did end swiping view at location: \(location)")
                }
                self.swipeableView.didSwipe = {view, direction, vector in
                    print("Did swipe view in direction: \(direction), vector: \(vector)")
                }
                self.swipeableView.didCancel = {view in
                    print("Did cancel swiping view")
                }
                self.swipeableView.didTap = {view, location in
                    print("Did tap at location \(location)")
                    
                    let url = URL(string:  self.dataToCards[view.tag].url)!
                    
                    self.playVideo(url: url)
                }
                self.swipeableView.didDisappear = { view in
                    print("Did disappear swiping view")
                }
                self.swipeableView.nextView = {
                    return self.nextCardView()
                }
                ///super.viewDidLoad()
            }
            
        })
        
    }
    
    
    
    
    var swipeableView: ZLSwipeableView!
    
    
    

    
    
    
    
    // MARK: ()
    func nextCardView() -> UIView? {
        if vedioIndex >= dataToCards.count {
            vedioIndex = 0
        }
        
        let imageView = UIImageView(frame: swipeableView.bounds)
        imageView.tag = vedioIndex
        imageView.backgroundColor = UIColor.yellow
        imageView.sd_setImage(with: URL.init(string: dataToCards[vedioIndex].imageUrl), completed: nil)
        vedioIndex += 1

        return imageView
    }
    
    
    
    
    
    func playVideo(url: URL) {
        let player = AVPlayer(url: url)
        
        let vc = AVPlayerViewController()
        vc.player = player
        
        self.present(vc, animated: true) { vc.player?.play() }
    }
    
}

