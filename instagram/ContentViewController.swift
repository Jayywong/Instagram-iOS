//
//  ContentViewController.swift
//  instagram
//
//  Created by Jason Wong on 3/8/17.
//  Copyright © 2017 Jason Wong. All rights reserved.
//

import UIKit
import Parse

class ContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var postTable: UITableView!
    
    var posts: [PFObject]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTable.delegate = self
        postTable.dataSource = self
        
        retrievePost()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retrievePost()
    {
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        query.findObjectsInBackground {(posts: [PFObject]?, error: Error?) in
            if let posts = posts
            {
                print("success")
                self.posts = posts
                self.postTable.reloadData()
            }else
            {
                print("failed to retrieve data : \(error?.localizedDescription)")
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts?.count ?? 0
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = postTable.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        cell.post = posts[indexPath.row]
        
        cell.selectionStyle = .none
        
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
