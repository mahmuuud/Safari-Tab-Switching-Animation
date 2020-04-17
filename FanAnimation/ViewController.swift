//
//  ViewController.swift
//  FanAnimation
//
//  Created by mahmoud mohamed on 4/17/20.
//  Copyright © 2020 MahmudElkassry. All rights reserved.
//  github: https://github.com/mahmuuud

import UIKit

class ViewController: UIViewController {
    
    let images: [UIImage] = [#imageLiteral(resourceName: "silhouette-of-person-holding-glass-mason-jar-1274260"), #imageLiteral(resourceName: "stars-1257860"), #imageLiteral(resourceName: "starry-sky-night-102539")]
    var imageViews: [ImageCard] = []
    
    @IBOutlet weak private var toolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for image in images {
            let imageView = ImageCard(image: image)
            imageView.layer.anchorPoint.y = 0.0
            imageView.frame = view.bounds
            view.insertSubview(imageView, belowSubview: toolbar)
            imageViews.append(imageView)
        }
        var prespective = CATransform3DIdentity
        prespective.m34 = -1/250
        view.layer.sublayerTransform = prespective
    }
    
    @IBAction private func infoButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Photos From", message: "https://www.pexels.com", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction private func bookmarkButtonTapped(_ sender: Any) {
        var imageYOffset: CGFloat = 50
        for subView in view.subviews {
            guard let imageView = subView as? ImageCard else {
                continue
            }
            var imageTransform = CATransform3DIdentity
            imageTransform = CATransform3DTranslate(imageTransform, 0, imageYOffset, 0)
            imageTransform = CATransform3DScale(imageTransform, 0.95, 0.6, 1)
            imageTransform = CATransform3DRotate(imageTransform, .pi/20, -1, 0, 0)
            let anim = CABasicAnimation(keyPath: "transform")
            anim.duration = 0.33
            anim.fromValue = NSValue(caTransform3D: imageView.layer.transform)
            anim.toValue = NSValue(caTransform3D: imageTransform)
            imageView.layer.add(anim, forKey: nil)
            imageYOffset += imageView.bounds.height / CGFloat(images.count)
            imageView.layer.transform = imageTransform
            imageView.didSelect = selectImage
        }
    }
    
    func selectImage(selectedImage: UIImageView) {
        for subView in view.subviews {
            
            guard let imageView = subView as? UIImageView else {
                continue
            }
            
            if imageView == selectedImage {
                UIView.animate(withDuration: 0.33, delay: 0, options: .curveEaseIn, animations: {
                    imageView.layer.transform = CATransform3DIdentity
                }) { [weak self] (_) in
                    self?.view.bringSubviewToFront(imageView)
                    self?.view.bringSubviewToFront(self?.toolbar ?? UIView())
                }
            } else {
                UIView.animate(withDuration: 0.33, delay: 0, options: .curveEaseIn, animations: {
                    imageView.alpha = 0
                }) { (_) in
                    imageView.alpha = 1
                    imageView.layer.transform = CATransform3DIdentity
                }
            }
        }
    }
    
}

