//
//  FirstViewController.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//


import UIKit
import Firebase
import IGListKit

class FirstViewController: UIViewController, FeedDelegate,IGListScrollDelegate,IGListAdapterDataSource,CellActionDelegate{
    
    
    @IBOutlet var collectionView: IGListCollectionView!
    @IBOutlet var feedVM: FeedModel!
    
    lazy var adaptor:IGListAdapter = {
        return IGListAdapter(updater:IGListAdapterUpdater(),viewController:self , workingRangeSize:0)
    }()
    var posts = [Post]()
    /*+===================TEST========================*/
    
    
    var testpost:Post = {let post = Post()
        post.postType = 1
        post.fileName = "New format of Registeration"
        post.fileType = "pdf"
        post.postId = "oneone1"
        return post}()
    var testpost2:Post = {let post = Post()
        post.postType = 1
        post.fileName = "Business communication notes"
        post.fileType = "pdf"
        post.postId = "oneone2"
        return post}()
    var testpost3:Post = {let post = Post()
        post.postType = 1
        post.fileName = "Business environment notes"
        post.fileType = "pdf"
        post.postId = "oneone3"
        return post}()
    
    /*============================================*/
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.adaptor.collectionView = collectionView
        self.adaptor.dataSource = self
        self.feedVM.delegate = self
        if Reachability.isConnectedToNetwork(){
            feedVM.downloadPosts()
            
        }else{
            let alert = UIAlertController(title:"NO Internet Connection" , message:"Make sure your device is connected to internet." , preferredStyle: .alert)
            let action = UIAlertAction(title: "OK" , style: .cancel , handler: nil)
            alert.addAction(action)
            present(alert, animated: true , completion: nil)
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let barbutton = tabBarController?.navigationItem.rightBarButtonItem
        barbutton?.target = self
        barbutton?.action = #selector(self.addPostAction)
    }
    
    func didFinishDownloadingInitialPosts(initialPosts: [Post]) {
        self.posts = initialPosts
        //posts.insert(testpost, at: 0)
        // posts.insert(testpost2, at: 3)
        // posts.insert(testpost3, at: 5)
        self.adaptor.performUpdates(animated: true)
    }
    
    
    func didFinishedDownloadingnewPost(newPost: Post) {
        self.posts.insert(newPost, at: 0)
        self.adaptor.performUpdates(animated: true)
    }
    
    func didFinishDownLoadingMorePosts(morePosts: [Post]) {
        self.posts += morePosts
        self.adaptor.performUpdates(animated: true)
    }
    
    func addPostAction(){
     let vc = storyboard?.instantiateViewController(withIdentifier: "addPost")
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return posts
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        let feedSc = ClassFeedSectionController()
        feedSc.firstFeed = self
        feedSc.scrollDelegate = self
        return feedSc
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
    
    func listAdapter(_ listAdapter: IGListAdapter!, didEndDragging sectionController: IGListSectionController!, willDecelerate decelerate: Bool) {
        if sectionController.isLastSection{
            feedVM.downloadMorePosts()
        }
    }
    
    func listAdapter(_ listAdapter: IGListAdapter!, didScroll sectionController: IGListSectionController!) {
        
    }
    
    func listAdapter(_ listAdapter: IGListAdapter!, willBeginDragging sectionController: IGListSectionController!) {
        
    }
    
    let scrollView = UIScrollView()
    var imageView = UIImageView()
    var originalView:UIImageView!
    var originalFrame = UIImageView()
    
    func didTapedOnImageView(postImageView: UIImageView ,View:UIView) {
        originalView = postImageView
        originalFrame.frame = (postImageView.superview?.convert(postImageView.frame, to: nil))!
        scrollView.frame = self.view.frame
        scrollView.backgroundColor = UIColor.black
        scrollView.alpha = 0
        self.view.addSubview(scrollView)
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.frame = (postImageView.superview?.convert(postImageView.frame, to: nil))!
        imageView.image = postImageView.image
        imageView.addGestureRecognizer(UITapGestureRecognizer(target:self , action: #selector(self.rollBack)))
        self.view.addSubview(imageView)
        self.originalView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.scrollView.alpha = 1.0
            self.imageView.frame = CGRect(x:0,y:self.view.frame.height/2 - self.imageView.frame.height/2,width:postImageView.frame.width,height:postImageView.frame.height)
        }
    }
    
    func rollBack(){
        UIView.animate(withDuration: 0.5, animations: {
            self.imageView.frame = self.originalFrame.frame
            self.scrollView.alpha = 0
            
        }) { (value) in
            self.originalView.alpha = 1
            self.imageView.removeFromSuperview()
            self.scrollView.removeFromSuperview()
        }
        
    }
    
    
}

