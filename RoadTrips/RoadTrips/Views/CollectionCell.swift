//
//  CollectionCell.swift
//  RoadTrips
//
//  Created by Maram Al shahrani on 20/05/1443 AH.
//

import UIKit
import SDWebImage
class CityCell: UICollectionViewCell {
    static let ID = "CellID"
    
    private var tripImage: UIImageView = {
       let image = UIImageView()
        
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    private var tripTitle: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.init(named: "WhiteColor")!
        title.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 20, weight: .bold))
        return title
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")}
    override func layoutSubviews() {
        setupSizeForCellContent()
    }
    func setCell(card: Vaction){
        tripImage.sd_setImage(with: URL.init(string: card.image), completed: nil)
        if Language.current.rawValue == "ar" {
        tripTitle.text          = card.title_ar
        }else{
            tripTitle.text          = card.title
        }
        
    }
    private func setupSizeForCellContent() {
        tripImage.frame = self.bounds
        
        
        
    }
    private func setupCell() {
        self.backgroundColor = .systemBackground
        self.addSubview(tripImage)
        self.addSubview(tripTitle)
        tripTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            
            tripTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: contentView.frame.height - 10),
            tripTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            tripTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
            
        ])
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        
    }
}
extension UIView {
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}
