//
//  SecondViewController.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

//
//  SecondViewController.swift
//  Scholacore
//
//  Created by Tarun kaushik on 24/04/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit
import IGListKit
import Firebase

class ClassFeedViewController: UIViewController,ClassFeedDelegate ,IGListAdapterDataSource,IGListScrollDelegate , CellActionDelegate{
    
    @IBOutlet var collectionView: IGListCollectionView!
    @IBOutlet var classFeedVM: ClassFeedModel!
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
    lazy var adaptor:IGListAdapter = {
        return IGListAdapter(updater:IGListAdapterUpdater(), viewController: self , workingRangeSize: 0)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.adaptor.collectionView = collectionView
        adaptor.dataSource = self
        classFeedVM.delegate = self
        if Reachability.isConnectedToNetwork(){
            classFeedVM.downloadPosts()
        }else{
            let alert = UIAlertController(title:"NO Internet Connection" , message:"Make sure your device is connected to internet." , preferredStyle: .alert)
            let action = UIAlertAction(title: "OK" , style: .cancel , handler: nil)
            alert.addAction(action)
            present(alert, animated: true , completion: nil)
            
        }
    }
    
    func didFinishDownloadingInitialPosts(initialPosts: [Post]) {
        // self.posts = initialPosts
        self.adaptor.performUpdates(animated: true)
    }
    
    func didFinishedDownloadingnewPost(newPost: Post) {
        // self.posts.insert(newPost, at: 0)
        self.adaptor.performUpdates(animated: true)
    }
    
    func didFinishDownLoadingMorePosts(morePosts: [Post]) {
        //self.posts += morePosts
        self.adaptor.performUpdates(animated: true)
    }
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        posts.insert(testpost, at: 0)
        posts.insert(testpost2, at: 0)
        posts.insert(testpost3, at: 0)
        return posts
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        let classFeedSC = ClassFeedSectionController()
        classFeedSC.scrollDelegate = self
        classFeedSC.firstFeed = self
        return classFeedSC
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
    
    
    func listAdapter(_ listAdapter: IGListAdapter!, didEndDragging sectionController: IGListSectionController!, willDecelerate decelerate: Bool) {
        if sectionController.isLastSection{
            print("its last ")
            classFeedVM.downloadMorePosts()
        }
        
    }
    
    func listAdapter(_ listAdapter: IGListAdapter!, didScroll sectionController: IGListSectionController!) {
        
    }
    
    func listAdapter(_ listAdapter: IGListAdapter!, willBeginDragging sectionController: IGListSectionController!) {
        
    }
    
    func didTapedOnImageView(postImageView: UIImageView, View: UIView) {
        
    }
    
    
    
    
}


