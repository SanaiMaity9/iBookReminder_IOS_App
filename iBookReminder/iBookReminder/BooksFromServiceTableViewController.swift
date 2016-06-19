//
//  BooksFromServiceTableViewController.swift
//  iBookReminder
//
//  Created by Manish on 19/11/15.
//  Copyright (c) 2015 ifconit. All rights reserved.
//

import UIKit
import CoreData


class BooksFromServiceTableViewController: UITableViewController {

    //outlets
    
    let managedObjectContext =
    (UIApplication.sharedApplication().delegate
        as! AppDelegate).managedObjectContext
    @IBOutlet var book_Tiltle: UILabel!
    
    @IBOutlet var book_Author: UILabel!
    
    @IBOutlet var book_Publisher: UILabel!
    
    @IBOutlet var book_Isbn: UILabel!
    
    @IBOutlet var book_Publisher_Date: UILabel!
    
    @IBOutlet var book_Categories: UILabel!
    
    @IBOutlet var book_Language: UILabel!
    
    @IBOutlet var book_Rating: UILabel!
    
    @IBOutlet var book_Description: UILabel!
    
    var booktitle = [String]()
    var bookauthor = [String]()
    var bookimg = [String]()
    var bookpublisher = [String]()
    var bookpublisherdate = [String]()
    var bookisbn = [String]()
    var bookcategories = [String]()
    var booklanguage = [String]()
    var bookaverageRating = [String]()
    var bookratingsCount = [String]()
    var bookdescription = [String]()
    var tap = 0

    
    var check = 0
    //
    @IBOutlet var frm: UIView!
    @IBOutlet var imgg: UIImageView!
    var index:Int!

    var bookTitle:String!
    var bookAuthor:String!
    var bookIsbn:String!
     var id:String!
    struct defaultsKeys {
       
        static let book_name = "bknm"
        static let book_author = "bkau"
        static let book_isbn = "bkisbn"
        static let book_index = "bkindx"
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
         navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
   id = UIDevice.currentDevice().identifierForVendor!.UUIDString
        frm.layer.shadowColor = UIColor.blackColor().CGColor
        frm.layer.shadowOffset = CGSize(width: 0, height: 2)
        frm.layer.shadowOpacity = 0.4
        frm.layer.shadowRadius = 5
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapGesture:")
        
        // add it to the image view;
        self.imgg.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        self.imgg.userInteractionEnabled = true
        book_Description.textAlignment = NSTextAlignment.Justified
        
        if imgg.image != UIImage(named: "") {
            
            
            
        }else{
          imgg.image = UIImage(named: "Noimg_icon")
        }
        
        
        //
        
        let defaults = NSUserDefaults.standardUserDefaults()

        if let ind = defaults.valueForKey(defaultsKeys.book_index) as? Int! {
            index = ind// Some String Value
        }
        if let bt = defaults.valueForKey(defaultsKeys.book_name) as? String! {
            bookTitle = bt// Some String Value
        }
        
        if let au = defaults.valueForKey(defaultsKeys.book_author) as? String! {
            bookAuthor = au// Some String Value
        }
        
        if let ibn = defaults.valueForKey(defaultsKeys.book_isbn) as? String! {
            bookIsbn = ibn// Some String Value
        }

        
        //coding for service
       
        
        if self.self.bookauthor[self.index] == ""{
            
            self.book_Author.text = "NA"
        }
        else{
        self.book_Author.text = self.bookauthor[self.index]
        }
        
        if self.self.booktitle[self.index] == ""{
            
            self.book_Tiltle.text = "NA"
        }
        else{
        self.book_Tiltle.text = self.booktitle[self.index]
        }
        
        if self.bookpublisher[self.index] == ""{
            
            self.book_Publisher.text = "NA"
        }
        else{
        self.book_Publisher.text = self.bookpublisher[self.index]
        }
        
        if self.bookpublisherdate[self.index] == ""{
            
            self.book_Publisher_Date.text = "NA"
        }
        else{
        self.book_Publisher_Date.text = self.bookpublisherdate[self.index]
        }
        
        if self.bookisbn[self.index] == ""{
            
            self.book_Isbn.text = "NA"
        }
        else{
        self.book_Isbn.text = self.bookisbn[self.index]
        }
        
        if self.bookcategories[self.index] == ""{
            
            self.book_Categories.text = "NA"
        }
        else{
        self.book_Categories.text = self.bookcategories[self.index]
        }
        
        
        if self.booklanguage[self.index] == ""{
            
            self.book_Language.text = "NA"
        }
        else{
        self.book_Language.text = self.booklanguage[self.index]
        }
        
        
        if self.bookaverageRating[self.index] == "" || self.bookratingsCount[self.index] == "" {
            self.book_Rating.text = "NA"
        }
       else if self.bookaverageRating[self.index] == ""{
            
            self.book_Rating.text = "NA(\(self.bookratingsCount[self.index]))"
            
        }else if self.bookratingsCount[self.index] == ""{
             self.book_Rating.text = "\(self.bookaverageRating[self.index])(0))"
            
        }
        else{
        
        self.book_Rating.text = "\(self.bookaverageRating[self.index])(\(self.bookratingsCount[self.index]))"
        
        }
        
        
        
        
        if self.bookdescription[self.index] == ""{
            
            self.book_Description.text = "NA"
        }
        else{
        self.book_Description.text = self.bookdescription[self.index]
        }
        var imgURL: NSURL = NSURL(string: bookimg[self.index] as String)!
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        NSURLConnection.sendAsynchronousRequest(
            request, queue: NSOperationQueue.mainQueue(),
            completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                if error == nil {
                    self.imgg.image = UIImage(data: data)
                    
                }
        })
        
        //
        
    }
   
    // MARK: - Table view data source
    func tapGesture(gesture: UIGestureRecognizer) {
        println("tap")
        if self.tap == 0{
            self.tap = 1
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        self.imgg.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        
    UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Fade)
       navigationController?.navigationBarHidden = true
        self.tableView.scrollEnabled = false
        self.tableView.addSubview(self.imgg)
            
        }else{
            self.tap = 0
            self.imgg.frame = CGRect(x: 130, y: 20, width: 59, height: 83)
            UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Slide)
            navigationController?.navigationBarHidden = false
            self.tableView.scrollEnabled = true
            self.tableView.addSubview(self.imgg)

            
        }
        
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 10
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }

    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        header.textLabel.font = UIFont (name: "HelveticaNeue-Thin", size: 15)
        header.backgroundView?.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
        
        
        
    }
    
    // table view header height = 25 and first header = 0
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0){
            return CGFloat(0)
        }
        return CGFloat(22);
    }
    
    //table view footer height = 0
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(0);
    }


    @IBAction func Saving(sender: AnyObject) {
        
            let entityDescription =
            NSEntityDescription.entityForName("Book",
                inManagedObjectContext: managedObjectContext!)
            
            let book = Book(entity: entityDescription!,
                insertIntoManagedObjectContext: managedObjectContext)
            
            book.title = self.booktitle[self.index]
            book.author = self.bookauthor[self.index]
            book.isbn_no = self.bookisbn[self.index]
            book.desption = self.bookdescription[self.index]
            book.rating = 0.0 as NSNumber!
            
            let image = imgg.image
            book.bookimg = NSData(data: UIImageJPEGRepresentation(image, 1.0))
            var error: NSError?
            //
            
            
            
            let request = NSFetchRequest()
            request.entity = entityDescription
            
            
            var objects = managedObjectContext?.executeFetchRequest(request,
                error: &error)
            for var i=0; i<objects!.count; i++ {
                if  var results = objects {
                    
                    var match = results[i] as! NSManagedObject
                    var e = match.valueForKey("id") as! NSNumber!
                    
                    if e == nil{
                        book.id = 1
                    }else {
                        book.id = i + 1
                    }
                    
                }
            }
            
            
            
            //
            
            
            managedObjectContext?.save(&error)
            
            
            if let err = error
            {
                println("error")
                
                var refreshAlert = UIAlertController(title: "iBook Reminder", message: "Book information has not been saved successfully", preferredStyle: UIAlertControllerStyle.Alert)
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                    self.navigationController?.popViewControllerAnimated(true)
                }))
                
                presentViewController(refreshAlert, animated: true, completion: nil)
            }
            else
            {
                println("data saved")
                
                var refreshAlert = UIAlertController(title: "iBook Reminder", message: "Book information has been saved successfully", preferredStyle: UIAlertControllerStyle.Alert)
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                    self.navigationController?.popViewControllerAnimated(true)
                }))
                
                presentViewController(refreshAlert, animated: true, completion: nil)
                
                
                
            }
            
            
        }
    
    
    
    
}
