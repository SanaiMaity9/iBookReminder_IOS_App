//
//  SearchResultTableViewController.swift
//  iBookReminder
//
//  Created by Manish on 18/11/15.
//  Copyright (c) 2015 ifconit. All rights reserved.
//

import UIKit
import Foundation

class SearchResultTableViewController: UITableViewController {

    var book_Service:BooksFromServiceTableViewController!
   
    @IBOutlet var tableview: UITableView!
    var bookTitle:String!
    var bookAuthor:String!
    var bookIsbn:String!
    var id:String!
    var book_Title = [String]()
    var book_Author = [String]()
    var book_Img = [String]()
    var book_Publisher = [String]()
    var book_Publisherdate = [String]()
    var book_Isbn = [String]()
    var book_Categories = [String]()
    var book_Language = [String]()
    var book_AverageRating = [String]()
    var book_RatingsCount = [String]()
    var book_Description = [String]()
    var check = 0
    
    var boxView = UIView()
    struct defaultsKeys {
        static let book_name = "bknm"
        static let book_author = "bkau"
        static let book_isbn = "bkisbn"
        static let book_index = "bkindx"
        
    }
    var activityIndicatorView: ActivityIndicatorView!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tabBarController?.tabBar.hidden = true
        id = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        //
        if self.book_Title.count > 0 {
            println("end loading")
            self.activityIndicatorView.stopAnimating()
            
        }else  {
            self.activityIndicatorView = ActivityIndicatorView(title: "", center: self.view.center)
            self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
            
            
            self.activityIndicatorView.startAnimating()
        }

        //
      
        
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let bt = defaults.valueForKey(defaultsKeys.book_name) as? String! {
            bookTitle = bt// Some String Value
        }
        
        if let au = defaults.valueForKey(defaultsKeys.book_author) as? String! {
            bookAuthor = au// Some String Value
        }
        
        if let ibn = defaults.valueForKey(defaultsKeys.book_isbn) as? String! {
            bookIsbn = ibn// Some String Value
        }
        
        //
        if check == 0 {
           
            let urlPath: String = "http://52.88.165.30/ibookreminder/WS/services.php?mode=search_book&title=&author=&isbn=&device_id="
            var url: NSURL = NSURL(string: urlPath)!
            var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
            
            request.HTTPMethod = "POST"
            var stringPost="title=\(bookTitle)&author=\(bookAuthor)&isbn=\(bookIsbn)&device_id=\(id)" // Key and Value
            
            let data = stringPost.dataUsingEncoding(NSUTF8StringEncoding)
            
          //request.timeoutInterval = 1000
            request.HTTPBody=data
            request.HTTPShouldHandleCookies=false
            
            let queue:NSOperationQueue = NSOperationQueue()
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
                let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
               
                if (jsonResult != nil){
                    // Success
                    if jsonResult["code"] as! Int == 200{
                        println("200")
                        
                        if self.check == 0 {
                            for var i = 0; i<jsonResult["books"]!.count; i++ {
                                
                                var book = jsonResult["books"]!.objectAtIndex(i) as! NSDictionary
                                
                                if (self.nullToNil(book.valueForKey("title")) != nil)
                                {
                                    var t = book.valueForKey("title") as! String
                                    
                                    self.book_Title.append(t)
                                    
                                    
                                    
                                }else{
                                    self.book_Title.append("" as String)
                                    
                                }
                                
                                if (self.nullToNil(book.valueForKey("author")) != nil)
                                {
                                    var a = book.valueForKey("author") as! String
                                    
                                    
                                    self.book_Author.append(a)
                                    
                                    
                                    
                                }
                                else{
                                    self.book_Author.append("" as String)
                                    
                                }
                                
                                if (self.nullToNil(book.valueForKey("Thumbnail")) != nil)
                                {
                                    var b = book.valueForKey("Thumbnail") as! String
                                    
                                    
                                    self.book_Img.append(b)
                                    
                                    
                                }
                                else{
                                    self.book_Img.append("" as String)
                                }
                                if (self.nullToNil(book.valueForKey("publisher")) != nil)
                                {
                                    var c = book.valueForKey("publisher") as! String
                                    
                                    
                                    self.book_Publisher.append(c)
                                    
                                    
                                }
                                else{
                                    self.book_Publisher.append("" as String)
                                }
                                
                                if (self.nullToNil(book.valueForKey("publishedDate")) != nil)
                                {
                                    var d = book.valueForKey("publishedDate") as! String
                                    
                                    
                                    self.book_Publisherdate.append(d)
                                    
                                    
                                }
                                else{
                                    self.book_Publisherdate.append("" as String)
                                }
                                
                                if (self.nullToNil(book.valueForKey("isbn_13")) != nil)
                                {
                                    var e = book.valueForKey("isbn_13") as! String
                                    
                                    
                                    self.book_Isbn.append(e)
                                    
                                    
                                }
                                else{
                                    self.book_Isbn.append("" as String)
                                }
                                
                                
                                
                                if (self.nullToNil(book.valueForKey("categories")) != nil)
                                {
                                    var f = book.valueForKey("categories") as! String
                                    
                                    
                                    self.book_Categories.append(f)
                                    
                                    
                                }
                                else{
                                    self.book_Categories.append("" as String)
                                }
                                
                                
                                
                                if (self.nullToNil(book.valueForKey("language")) != nil)
                                {
                                    var g = book.valueForKey("language") as! String
                                    
                                    
                                    self.book_Language.append(g)
                                    
                                    
                                }
                                else{
                                    self.book_Language.append("" as String)
                                }
                                
                                if (self.nullToNil(book.valueForKey("averageRating")) != nil)
                                {
                                    if let s = book.valueForKey("averageRating") as? NSNumber {
                                        let l = s.stringValue
                                       
                                        self.book_AverageRating.append(l)
                                    } else if let t = book.valueForKey("averageRating") as? String {
                                        let m = t
                                       
                                        self.book_AverageRating.append("" as String)
                                    }else{
                                        println("other data type")
                                        self.book_AverageRating.append("" as String)
                                    }
                                    
                                    
                                }
                                else{
                                    self.book_AverageRating.append("" as String)
                                }
                                
                                if (self.nullToNil(book.valueForKey("ratingsCount")) != nil)
                                {
                                    if let s = book.valueForKey("ratingsCount") as? NSNumber {
                                        let l = s.stringValue
                                      
                                        self.book_RatingsCount.append(l)
                                    } else if let t = book.valueForKey("ratingsCount") as? String {
                                        let m = t
                                       
                                        self.book_RatingsCount.append("" as String)
                                    }else{
                                        println("other data type")
                                        self.book_RatingsCount.append("" as String)
                                    }
                                    
                                    
                                }
                                else{
                                    self.book_RatingsCount.append("" as String)
                                }
                                
                                
                                if (self.nullToNil(book.valueForKey("description")) != nil)
                                {
                                    var k = book.valueForKey("description") as! String
                                    
                                    
                                    self.book_Description.append(k)
                                    
                                    
                                }
                                else{
                                    self.book_Description.append("" as String)
                                }
                                
                                
                                
                            }
                            self.check = 1
                            self.activityIndicatorView.stopAnimating()
                            self.tableview.reloadData()
                            self.viewDidLoad()
                        
                            
                            
                        }
                        
                        
                    }else{
                        self.check = 400
                   
                        println("400")
                    
                    
                        var refreshAlert = UIAlertController(title: "iBook Reminder", message: "Book information was not found", preferredStyle: UIAlertControllerStyle.Alert)
                        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                            self.navigationController?.popViewControllerAnimated(true)
                        }))
                        self.presentViewController(refreshAlert, animated: true, completion: nil)
                        
                    }
                 self.tableview.reloadData()
               
                    let message = jsonResult["message"] as! NSString
                    
                    self.tableView.reloadData()
                    self.check = 1
                    println(message)
                }else {
                    // Failed
                    println("Failed")
                }
                
            })

        
           }
        
    }
  

    
   
    
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let DVC = segue.destinationViewController as! BooksFromServiceTableViewController//replace ViewController2 with the name of your 2nd VC
        DVC.booktitle = self.book_Title
        DVC.bookauthor = self.book_Author
        DVC.bookimg = self.book_Img
        DVC.bookpublisher = self.book_Publisher
        DVC.bookpublisherdate = self.book_Publisherdate
        DVC.bookisbn = self.book_Isbn
        DVC.bookcategories = self.book_Categories
        DVC.booklanguage = self.book_Language
        DVC.bookaverageRating = self.book_AverageRating
        DVC.bookratingsCount = self.book_RatingsCount
        DVC.bookdescription = self.book_Description
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
   
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return book_Title.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! FristviewCell
        
        
            cell.bknmm.text = self.book_Title[indexPath.row] as String
            cell.authornm.text = self.book_Title[indexPath.row] as String
            
            if book_Img[indexPath.row] == ""{
                cell.bki.image = UIImage(named: "Noimg_icon")
            }else{
            var imgURL: NSURL = NSURL(string: book_Img[indexPath.row] as String)!
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            NSURLConnection.sendAsynchronousRequest(
                request, queue: NSOperationQueue.mainQueue(),
                completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                    if error == nil {
                        cell.bki.image = UIImage(data: data)
                        
                    }
            })
        }
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch(indexPath.row)
        {
            case 0...indexPath.row :
                
            
            let defaults = NSUserDefaults.standardUserDefaults()
            
            defaults.setValue(indexPath.row, forKey: defaultsKeys.book_index)
            
            //self.performSegueWithIdentifier("bookdetails", sender: self)
            break;
            
            
        default:
            
            println("\(indexPath.row) is selected");
        }
        
        
        
    }
   
    func nullToNil(value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return nil
        } else {
            return value
        }
    }

    
}
