//
//  ImageCard.swift
//  FanAnimation
//
//  Created by mahmoud mohamed on 4/17/20.
//  Copyright © 2020 MahmudElkassry. All rights reserved.
//  github: https://github.com/mahmuuud

import Foundation
import UIKit

class ImageCard: UIImageView {
    
    var didSelect: ((UIImageView)->())?
    
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                    action: #selector(ImageCard.didTapHandler(_:))))
    }
    
    @objc func didTapHandler(_ tap: UITapGestureRecognizer) {
        didSelect?(self)
    }
}
