//
//  ViewController.swift
//  tableAppSwift
//
//  Created by Semen Matsepura on 09.01.16.
//  Copyright © 2016 Semen Matsepura. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBarTopLayout: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var previousScrollViewYOffset: CGFloat = 0.0
    var up = true
    
    //    MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.barTintColor = UIColor.lightGrayColor()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 47
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.backgroundColor = randomColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
    }
    
    //    MARK: - Scroll view did scroll
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var frame = searchBar.frame
        let size = frame.width - 21
        let scrollOffset = scrollView.contentOffset.y
        let scrollDiff = scrollOffset - previousScrollViewYOffset
        let scrollHeight = scrollView.frame.height
        let scrollContentSizeHeight = scrollView.contentSize.height + scrollView.contentInset.bottom
        
        if scrollOffset - 64 <= scrollView.contentInset.top {
            
            frame.origin.y = 64
            up = true
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                self.searchBar.frame = frame
                
            })
            
        } else if scrollOffset + scrollHeight >= scrollContentSizeHeight {
            frame.origin.y = -size
            
        } else {
            
            frame.origin.y = min(20, max(-size, frame.origin.y - scrollDiff))
            
            if up == true {
                frame.origin.y = 20
                up = false
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.searchBar.frame = frame
                })
            }
        }
        
        self.searchBar.frame = frame
        previousScrollViewYOffset = scrollOffset
    }
    
    //    MARK: - Random color
    
    func randomColor () -> UIColor {
        
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    
    
}

