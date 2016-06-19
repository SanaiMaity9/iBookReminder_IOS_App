//
//  BookInfoController.swift
//  Book
//
//  Created by Manish on 09/10/15.
//  Copyright (c) 2015 ifconit. All rights reserved.
//

import UIKit
import CoreData

class BookInfoController: UITableViewController{
    
    //
    
    @IBOutlet var img: UIImageView!
    
    @IBOutlet var floatRatingView: FloatRatingView!
   
    @IBOutlet var lbnm: UILabel!
 
    @IBOutlet var lbau: UILabel!
    
    @IBOutlet var lbis: UILabel!
     var readCheck = 0
    var purchaseCheck = 0
    var favCheck = 0
    var isbn:String!
    var id:String!
    var rt:Float!
    
    @IBOutlet var lbdes: UILabel!
    
    @IBOutlet var favck: UIImageView!
    
    @IBOutlet var rdck: UIImageView!
    @IBOutlet var payck: UIImageView!
    
    
    //
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    @IBOutlet var imgsh: UIView!
    
    //index of selected book
    var  k:NSNumber!
   
    struct defaultsKeys {
        static let bkid = "bki"
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.hidden = true
        //
       id = UIDevice.currentDevice().identifierForVendor!.UUIDString
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //
        //
   
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let st = defaults.valueForKey(defaultsKeys.bkid) as? NSNumber! {
           k = st// Some String Value
        }
      
 
        //database coding retrive data
        
        let entityDescription =
        NSEntityDescription.entityForName("Book",
            inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        var error: NSError?
        
        var objects = managedObjectContext?.executeFetchRequest(request,
            error: &error)
  
        
        var u = k as Int!
        
            if  var results = objects {
                
                println(u)
               
                if results.count > 0 {
                    let match = results[u] as! NSManagedObject
                    
              lbnm.text = match.valueForKey("title") as? String!
              lbau.text = match.valueForKey("author") as? String!
               lbis.text = match.valueForKey("isbn_no") as? String!
                    isbn = match.valueForKey("isbn_no") as? String!
               lbdes.text = match.valueForKey("desption") as? String!
                    var t = match.valueForKey("bookimg") as! NSData!
                    img.image = UIImage(data: t)
 
                    var m = match.valueForKey("read") as? NSNumber!
                    println("read = \(m)")
                    var tyh = match.valueForKey("purchase") as? NSNumber!
                    println("purchase = \(tyh)")
                   var ty = match.valueForKey("fav") as? NSNumber!
                    println("fav = \(ty)")
                    println("rating = \(rt)")
                    rt = match.valueForKey("rating") as? Float!
                    
                    //println(m)
                    if m == Optional(0) {
                        self.rdck.image = UIImage(named: "Cross_icon")
                        
                    }else if m == Optional(1){
                        println("read = \(m)")
                        self.rdck.image = UIImage(named: "Check_blue")
                    }
                    //
                  
                    if tyh == Optional(0) {
                        self.payck.image = UIImage(named: "Cross_icon")
                        
                    }else if tyh == Optional(1){
                        println("purchase = \(tyh)")
                        self.payck.image = UIImage(named: "Check_green")
                    }
                    if ty == Optional(0) {
                        self.favck.image = UIImage(named: "Cross_icon")
                        
                    }else if ty == Optional(1){
                        println("fav = \(ty)")
                        self.favck.image = UIImage(named: "Check_red")
                    }

             
                    
                } else {
                   println("No Match")
                }
                
            }
            
        //
        self.floatRatingView.emptyImage = UIImage(named: "Emptystar_icon")
        self.floatRatingView.fullImage = UIImage(named: "Fullstar_icon")
        // Optional params
      //  self.floatRatingView.delegate = self
        self.floatRatingView.contentMode = UIViewContentMode.ScaleAspectFit
        self.floatRatingView.maxRating = 5
        self.floatRatingView.minRating = 1
        self.floatRatingView.rating = rt
        self.floatRatingView.editable = true
        self.floatRatingView.halfRatings = false
        self.floatRatingView.floatRatings = true

        
        //
        
       
        
        //
        

       imgsh.layer.shadowOffset = CGSize(width: 3, height: 3)
       imgsh.layer.shadowOpacity = 0.7
       imgsh.layer.shadowRadius = 2
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapGesture:")
        
        // add it to the image view;
        self.rdck.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        self.rdck.userInteractionEnabled = true

        let tapGesture1 = UITapGestureRecognizer(target: self, action: "tapGesture1:")
        
        // add it to the image view;
        self.payck.addGestureRecognizer(tapGesture1)
        // make sure imageView can be interacted with by user
        self.payck.userInteractionEnabled = true
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: "tapGesture2:")
        
        // add it to the image view;
        self.favck.addGestureRecognizer(tapGesture2)
        // make sure imageView can be interacted with by user
        self.favck.userInteractionEnabled = true

        
    }
    
    func Getdata(){
        let urlPath: String = "http://52.88.165.30/ibookreminder/WS/services.php?mode=book_status&title=&author=&isbn=&device_id=&book_purchased=&book_read=&book_fav="
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        var stringPost="isbn=\(isbn)&device_id=\(id)&book_purchased=\(purchaseCheck)&book_read=\(readCheck)&book_fav=\(favCheck)" // Key and Value
        
        let data = stringPost.dataUsingEncoding(NSUTF8StringEncoding)
        
        request.timeoutInterval = 60
        request.HTTPBody=data
        request.HTTPShouldHandleCookies=false
        
        let queue:NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            
            if (jsonResult != nil) {
                // Success
                if jsonResult["code"] as! Int == 200{
                    println("200")
                    
                    
                }else{
                    println("400")
                    
                }
                
                let message = jsonResult["message"] as! NSString
                println(message)
            }else {
                // Failed
                println("Failed")
            }
            
        })


    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        viewDidLoad()
        tableView.reloadData()
        
        
    }

    
    func tapGesture(gesture: UIGestureRecognizer) {
        
        if rdck.image == UIImage(named: "Check_blue"){
            
            //
            var ee = k as Int!
            let entityDescription =
            NSEntityDescription.entityForName("Book",
                inManagedObjectContext: managedObjectContext!)
            
            let request = NSFetchRequest()
            request.entity = entityDescription
            
            var error: NSError?
            
            var objects = managedObjectContext?.executeFetchRequest(request,
                error: &error)
            
            if let results = objects {
                
                if results.count > 0 {
                    let match = results[ee] as! NSManagedObject
                    match.setValue(0 as NSNumber!, forKey: "read")
                    readCheck = 0
                    Getdata()
                    match.setValue(0.0 as Float!, forKey: "rating")
                    managedObjectContext?.save(nil)
                    
                    viewDidLoad()
                    tableView.reloadData()
                    
                } else {
                    println("error")
                   

                }
            }
        
            //
            
            rdck.image = UIImage(named: "Cross_icon")
            
            
        }else{
            
            //
            var ee = k as Int!
            let entityDescription =
            NSEntityDescription.entityForName("Book",
                inManagedObjectContext: managedObjectContext!)
            
            let request = NSFetchRequest()
            request.entity = entityDescription
            
            var error: NSError?
            
            var objects = managedObjectContext?.executeFetchRequest(request,
                error: &error)
            
            if let results = objects {
                
                if results.count > 0 {
                    let match = results[ee] as! NSManagedObject
                    match.setValue(1 as NSNumber!, forKey: "read")
                  readCheck = 1
                    Getdata()
                    managedObjectContext?.save(nil)
                    
                    let vc = CustomAlertViewController()
                    self.presentViewController(vc, animated: true, completion: nil)
                    
                    viewDidLoad()
                    tableView.reloadData()
                    
                } else {
                    println("error")
                    
                    
                }
            //
            
            rdck.image = UIImage(named: "Check_blue")
        
            }
        }
        
    }

    
    func tapGesture1(gesture: UIGestureRecognizer) {
        
       if payck.image == UIImage(named: "Check_green"){
        
        // database coding for purchase
        var ee = k as Int!
        let entityDescription =
        NSEntityDescription.entityForName("Book",
            inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        var error: NSError?
        
        var objects = managedObjectContext?.executeFetchRequest(request,
            error: &error)
        
        if let results = objects {
            
            if results.count > 0 {
                let match = results[ee] as! NSManagedObject
                match.setValue(0 as NSNumber!, forKey: "purchase")
                purchaseCheck = 0
                Getdata()
                managedObjectContext?.save(nil)
                
            } else {
                println("error")
            }
        }

        //
        
        
        
            payck.image = UIImage(named: "Cross_icon")
        }else{
        
        // setinf value 1 for purchase
        
        var ee = k as Int!
        let entityDescription =
        NSEntityDescription.entityForName("Book",
            inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        var error: NSError?
        
        var objects = managedObjectContext?.executeFetchRequest(request,
            error: &error)
        
        if let results = objects {
            
            if results.count > 0 {
                let match = results[ee] as! NSManagedObject
                match.setValue(1 as NSNumber!, forKey: "purchase")
                purchaseCheck = 1
                Getdata()
                managedObjectContext?.save(nil)
                
            } else {
                println("error")
            }
        }
    
            payck.image = UIImage(named: "Check_green")
        }

        
    }
    
    func tapGesture2(gesture: UIGestureRecognizer) {
        
        //Database coding for fav
        
        let entityDescription =
        NSEntityDescription.entityForName("Book",
            inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        var error: NSError?
        
        var objects = managedObjectContext?.executeFetchRequest(request,
            error: &error)
        
        
        var u = k as Int!
        
        if  var results = objects {
            
          
            
            if results.count > 0 {
                let match = results[u] as! NSManagedObject
                
                 var ty = match.valueForKey("fav") as? NSNumber!
                
                
                if ty == Optional(0) {
                    
                    
                    
                    favck.image = UIImage(named: "Check_red")
                    //
                    
                    if favck.image == UIImage(named: "Check_red"){
                        
                        // coding for seting value 1 in fav
                        var ee = k as Int!
                        let entityDescription =
                        NSEntityDescription.entityForName("Book",
                            inManagedObjectContext: managedObjectContext!)
                        
                        let request = NSFetchRequest()
                        request.entity = entityDescription
                        
                        var error: NSError?
                        
                        var objects = managedObjectContext?.executeFetchRequest(request,
                            error: &error)
                        
                        if let results = objects {
                            
                            if results.count > 0 {
                                let match = results[ee] as! NSManagedObject
                                match.setValue(1 as NSNumber!, forKey: "fav")
                                favCheck = 1
                                Getdata()
                                managedObjectContext?.save(nil)
                                
                                let alertController = UIAlertController(title: "iBook Reminder ", message: "This book is marked as Favorite.", preferredStyle: .Alert)
                                self.presentViewController(alertController, animated: true, completion: nil)
                                let delay = 2.0 * Double(NSEC_PER_SEC)
                                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                                dispatch_after(time, dispatch_get_main_queue(), {
                                    alertController.dismissViewControllerAnimated(true, completion: nil)
                                })
                                
                            } else {
                                println("error")
                            }
                        }
                        
                    }

                    //end
                    
                    
                }else if ty == Optional(1){

                    favCheck = 1
                    Getdata()
                    let alertController = UIAlertController(title: "iBook Reminder ", message: " This book is already in Favorite.", preferredStyle: .Alert)
                    self.presentViewController(alertController, animated: true, completion: nil)
                    let delay = 2.0 * Double(NSEC_PER_SEC)
                    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                    dispatch_after(time, dispatch_get_main_queue(), {
                        alertController.dismissViewControllerAnimated(true, completion: nil)
                    })
                    
                }

                
            }
        }
  
        
        //
  
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 5
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }
    
    
    // the color of header section and font coding here
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        header.textLabel.font = UIFont (name: "HelveticaNeue-Thin", size: 14)
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
    
    //loading the view and table view reload fron another view controller
    func loadList(notification: NSNotification){
        //load data here
        self.viewDidLoad()
        self.tableView.reloadData()
    }
    
}
