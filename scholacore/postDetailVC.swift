//
//  postDetailVC.swift
//  scholacore
//
//  Created by Tarun kaushik on 04/07/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit
import SDWebImage

class postDetailVC: UITableViewController {

    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var postContentView: UITextView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    var post:Post!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.title = post.UserName
        //let button = navigationItem.leftBarButtonItem
        //button?.target = self
        //button?.action = #selector(self.goback)
        postImageView.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self , action : #selector(self.showImageDetail))
        postImageView.addGestureRecognizer(tapgesture)
        setup()
    }
    
    
    func goback(){
        dismiss(animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showImageDetail(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailNav") as! UINavigationController
        let target = vc.topViewController as! DetailViewController
        target.postImage = self.postImageView.image
        self.present(WithAnimation: vc)
    }
    
    func setup(){
        if let  imageUrl = post.postImageURL {
            self.postImageView.sd_setImage(with: URL(string: imageUrl))
        }
        postContentView.text = post.content
        userNameLabel.text = post.UserName
        dateLabel.text = post.Time
    }
    // MARK: - Table view data source

    //override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
      //  return 1
    //}

   // override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
     //   return
   // }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return getImageCellHeight()
        }else if indexPath.row == 3{
        return getContentCellHeight()
        }
    return 50
   }
    
    func getImageCellHeight() -> CGFloat{
        let width = tableView.bounds.size.width
        let height = width/post.imageAspectRatio!
        return height
    }
    
    func getContentCellHeight() -> CGFloat{
        let width = tableView.bounds.size.width
        let textView :UITextView = UITextView(frame:CGRect(x:0,y:0,width: width - 40 , height: 600))
        textView.font = .systemFont(ofSize: 17)
        textView.text = post?.content
        var frame = textView.frame
        frame.size.height = textView.contentSize.height
        print("content cell height \(textView.contentSize.height)")
        let height = textView.contentSize.height
        if textView.text == ""{
            return 40
        }else{
            return height + 20
        }
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
