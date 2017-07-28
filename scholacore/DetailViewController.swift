//
//  DetailViewController.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//


import UIKit

class DetailViewController: UIViewController,UIScrollViewDelegate{
    var postImageView:UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Userimage"))
        
        return imageView
    }()
    var detailScrollView = UIScrollView()
    var postImage:UIImage!
    var defaultzoomScale = CGFloat()
    var backButton:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        button.frame = CGRect(x:10 , y: 10 ,width:30 , height: 30)
        return button
    }()
    
    @IBOutlet var dontDeleteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dontDeleteLabel.removeFromSuperview()
        navigationController?.navigationBar.tintColor = UIColor.white
        backButton.layer.cornerRadius = 15
        backButton.clipsToBounds = true
        postImageView.isUserInteractionEnabled = true
        postImageView = UIImageView(image: postImage)
        postImageView.image = postImage
        detailScrollView = UIScrollView(frame: self.view.frame)
        postImageView.frame.size.width = detailScrollView.bounds.size.width
        postImageView.frame.size.height = (postImageView.frame.size.width * postImage.size.height)/(postImage.size.width)
        detailScrollView.backgroundColor = UIColor.black
        detailScrollView.contentSize = postImageView.frame.size
        detailScrollView.showsHorizontalScrollIndicator = false
        detailScrollView.showsVerticalScrollIndicator = false
        updateMinZoomScaleForSize()
        centerTheImageView()
        detailScrollView.addSubview(postImageView)
        detailScrollView.delegate = self
        view.addSubview(detailScrollView)
        detailScrollView.maximumZoomScale = 3.0
        setupGestureReconizer()
        setupBackButton()
    }
    
    func setupBackButton(){
        let backbutton = navigationItem.leftBarButtonItem
        backbutton?.target = self
        backbutton?.action = #selector(self.didDownSwipe)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return postImageView
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let imageSize = postImageView.frame.size
        let scrollViewSize = scrollView.bounds.size
        let verticalPadding = imageSize.height < scrollViewSize.height ? (scrollViewSize.height - imageSize.height)/2 : 0
        let horizontalPadding = imageSize.width < scrollViewSize.width ? (scrollViewSize.width - imageSize.width)/2 :0
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding , left : horizontalPadding , bottom : verticalPadding , right: horizontalPadding)
        unhideNavigationBar()
    }
    
    func unhideNavigationBar(){
        if detailScrollView.zoomScale == detailScrollView.minimumZoomScale{
            navigationController?.navigationBar.isHidden = false
        }
    }
    
    private func updateMinZoomScaleForSize() {
        let imageViewSize = postImageView.bounds.size
        let scrollViewSize = detailScrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        let minScale = min(widthScale, heightScale)
        detailScrollView.minimumZoomScale = minScale
        // detailScrollView.setZoomScale(detailScrollView.minimumZoomScale, animated: true)
        
    }
    
    private func centerTheImageView(){
        let imageSize = postImageView.frame.size
        let scrollViewSize = detailScrollView.bounds.size
        let verticalPadding = imageSize.height < scrollViewSize.height ? (scrollViewSize.height - imageSize.height)/2 : 0
        let horizontalPadding = imageSize.width < scrollViewSize.width ? (scrollViewSize.width - imageSize.width)/2 :0
        detailScrollView.contentInset = UIEdgeInsets(top: verticalPadding - (navigationController?.navigationBar.frame.height)! * 1.5 , left : horizontalPadding , bottom : verticalPadding , right: horizontalPadding)
    }
    
    func setupGestureReconizer(){
        let doubleTap = UITapGestureRecognizer(target:self , action: #selector(self.handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        detailScrollView.addGestureRecognizer(doubleTap)
        let singleTap = UITapGestureRecognizer(target:self , action: #selector(self.didTapedOnImage))
        singleTap.numberOfTapsRequired = 1
        detailScrollView.addGestureRecognizer(singleTap)
        singleTap.require(toFail: doubleTap)
        let downSwipe = UISwipeGestureRecognizer(target:self , action: #selector(self.didDownSwipe))
        downSwipe.direction = .down
        detailScrollView.addGestureRecognizer(downSwipe)
        downSwipe.require(toFail: detailScrollView.panGestureRecognizer)
        
    }
    
    func handleDoubleTap(){
        if detailScrollView.zoomScale > detailScrollView.minimumZoomScale{
            detailScrollView.setZoomScale(detailScrollView.minimumZoomScale, animated: true)
            centerTheImageView()
        }else{
            detailScrollView.setZoomScale(detailScrollView.maximumZoomScale, animated: true)
        }
    }
    
    func didDownSwipe(){
        dismiss(animated: true, completion: nil)
        //self.performSegue(withIdentifier: "unwindToMainTab", sender: self )
    }
    
    func didTapedOnImage(){
        resetup()
    }
    
    func resetup(){
        navigationController?.navigationBar.isHidden = (navigationController?.navigationBar.isHidden == false)
    }
    
}



