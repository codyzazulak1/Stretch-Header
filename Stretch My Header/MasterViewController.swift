//
//  MasterViewController.swift
//  Stretch My Header
//
//  Created by Cody Zazulak on 2015-08-04.
//  Copyright (c) 2015 Cody Zazulak. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, UIScrollViewDelegate {

    var objects = [AnyObject]()
    var headerView:UIView!
    private let kTableHeaderHeight: CGFloat = 300.0

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        
        var newsItem1 = NewsItem(aCategory: "World", aHeadline: "Climate change protests, divestments meet fossil fuels realities")
        var newsItem2 = NewsItem(aCategory: "Europe", aHeadline: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'")
        var newsItem3 = NewsItem(aCategory: "Middle East", aHeadline: "Airstrikes boost Islamic State, FBI director warns more hostages possible")
        var newsItem4 = NewsItem(aCategory: "Africa", aHeadline: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim")
        var newsItem5 = NewsItem(aCategory: "Asia Pacific", aHeadline: "Despite UN ruling, Japan seeks backing for whale hunting")
        var newsItem6 = NewsItem(aCategory: "Americas", aHeadline: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria")
        var newsItem7 = NewsItem(aCategory: "World", aHeadline: "South Africa in $40 billion deal for Russian nuclear reactors")
        var newsItem8 = NewsItem(aCategory: "Europe", aHeadline: "'One million babies' created by EU student exchanges")
        
        objects = [newsItem1,newsItem2,newsItem3,newsItem4,newsItem5,newsItem6,newsItem7,newsItem8]
        
        configureTableView()
        
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)
        
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)

        tableView.contentInset = UIEdgeInsetsMake(kTableHeaderHeight, 0, 0, 0)
        tableView.contentOffset = CGPointMake(0, -kTableHeaderHeight)
        updateHeaderView()
        
    }
    
    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        if tableView.contentOffset.y < -kTableHeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        
        headerView.frame = headerRect
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row] as! NewsItem
            (segue.destinationViewController as! DetailViewController).detailItem = object
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func configureTableView() {
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return newsItemTableViewCellAtIndexPath(indexPath)
    }
    
    func newsItemTableViewCellAtIndexPath(indexPath:NSIndexPath) -> NewsItemTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NewsItemCell") as! NewsItemTableViewCell
        setCategoryForCell(cell, indexPath: indexPath)
        setHeadlineForCell(cell, indexPath: indexPath)
        return cell
    }
    
    func setCategoryForCell(cell:NewsItemTableViewCell, indexPath:NSIndexPath) {
        let item = objects[indexPath.row] as! NewsItem
        cell.categoryLabel.text = item.category
        
        if cell.categoryLabel.text == "World" {
            cell.categoryLabel.textColor = UIColor .greenColor()
        } else if cell.categoryLabel.text == "Europe" {
            cell.categoryLabel.textColor = UIColor .blueColor()
        } else if cell.categoryLabel.text == "Middle East" {
            cell.categoryLabel.textColor = UIColor .purpleColor()
        } else if cell.categoryLabel.text == "Africa" {
            cell.categoryLabel.textColor = UIColor .redColor()
        } else if cell.categoryLabel.text == "Asia Pacific" {
            cell.categoryLabel.textColor = UIColor .magentaColor()
        } else {
            cell.categoryLabel.textColor = UIColor .orangeColor()
        }
    }
    
    func setHeadlineForCell(cell:NewsItemTableViewCell, indexPath:NSIndexPath) {
        let item = objects[indexPath.row] as! NewsItem
        var subtitle: NSString? = item.headline
        
        if let subtitle = subtitle {
            
            // Some subtitles are really long, so only display the first 200 characters
            if subtitle.length > 200 {
                cell.headlineLabel.text = "\(subtitle.substringToIndex(200))..."
                
            } else {
                cell.headlineLabel.text = subtitle as String
            }
            
        } else {
            cell.headlineLabel.text = ""
        }
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

