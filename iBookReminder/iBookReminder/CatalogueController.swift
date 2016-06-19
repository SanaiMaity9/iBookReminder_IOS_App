//
//  catalogueController.swift
//  Book
//
//  Created by Manish on 09/10/15.
//  Copyright (c) 2015 ifconit. All rights reserved.
//

import UIKit
import CoreData

class CatalogueController: UITableViewController{
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
   
    @IBOutlet var Minusbar: UIBarButtonItem!
    var people = [NSManagedObject]()
    var label: UILabel!
    var  emcell:UITableViewCell!
    var lbvw:UIView!
    @IBOutlet var catt: UITableView!
    var ig:String!
    var sln = 0;
    var bkmn = [String]()
    var autnme = [String]()
    var ii:String!
    var Images = [String: UIImage]()
    var Images1 = [String]()
   var databasePath = NSString()
    @IBOutlet var emvw: UIView!
    var Btclick = 0;
    struct defaultsKeys {
        static let bkid = "bki"
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tabBarController?.tabBar.hidden = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
                   //
        let entityDescription =
        NSEntityDescription.entityForName("Book",
            inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        var error: NSError?
        
        
        var objects = managedObjectContext?.executeFetchRequest(request,
            error: &error)
        
        sln = objects!.count
        
        //
        label = UILabel(frame: CGRectMake(0, 0, 300, 100))
        
        if objects!.count > 0 {
            label.hidden = true
        // var label = UILabel(frame: CGRectMake(0, 0, 300, 100))
            let subViews = self.view.subviews
            for subview in subViews{
                if subview.tag == 999 {
                    subview.removeFromSuperview()
                    self.navigationItem.rightBarButtonItem!.image = UIImage(named: "Add_icon")
                    self.navigationItem.rightBarButtonItem?.enabled = true
                    self.navigationItem.leftBarButtonItem = nil
                    self.navigationItem.leftBarButtonItem = self.Minusbar
                    self.Minusbar.title = ""
                    self.Minusbar.image = UIImage(named: "Minus_icon")
                    self.Minusbar.enabled = true
               

            }
            }
        }
        else {
            //
            self.navigationItem.rightBarButtonItem!.image = UIImage(named: "Add_icon")
            self.navigationItem.rightBarButtonItem?.enabled = true
            self.Minusbar.title = ""
            self.Minusbar.image = UIImage(named: "")
            self.Minusbar.enabled = false
            
            //
            
            label.center = CGPointMake(150, 170)
            label.textColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
            
            //label.lineBreakMode = NSLineBreakMode.ByCharWrapping
            label.font = UIFont (name: "HelveticaNeue-Thin", size: 19)
            label.numberOfLines = 3
            label.tag = 999
            label.textAlignment = NSTextAlignment.Center
            label.text = " No list found. Click (+) to add new book details."
            
            self.view.addSubview(label)
             }
        // sqlite
        
        
        //
        
        
            }
   
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        viewDidLoad()
        tableView.reloadData()
       
        
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
          }

 

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
   
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! FristviewCell
        //
        
        //
        let entityDescription =
        NSEntityDescription.entityForName("Book",
            inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        var error: NSError?
        
        var objects = managedObjectContext?.executeFetchRequest(request,
            error: &error)
    if  var results = objects {
         
            var match = results[indexPath.row] as! NSManagedObject
       
               cell.bknmm.text = match.valueForKey("title") as! String!

       
                      cell.authornm.text =  match.valueForKey("author") as! String!
            var k = match.valueForKey("bookimg") as! NSData!
            cell.bki.image = UIImage(data: k)
        
        
            } else {
               println("No Match")
            }
        
     
        
        
        
        return cell
        
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
  
        return sln
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch(indexPath.row)
        {
    
        case 0...indexPath.row :
            
            self.performSegueWithIdentifier("info", sender: self)
            //
            let entityDescription =
            NSEntityDescription.entityForName("Book",
                inManagedObjectContext: managedObjectContext!)
            
            let request = NSFetchRequest()
            request.entity = entityDescription
            var error: NSError?
            
            var objects = managedObjectContext?.executeFetchRequest(request,
                error: &error)
            if  var results = objects {
                
                var match = results[indexPath.row] as! NSManagedObject
               
                var e = indexPath.row as NSNumber!

                let defaults = NSUserDefaults.standardUserDefaults()
                
                defaults.setValue(e, forKey: defaultsKeys.bkid)
                
                
                
                
            }
            break;
            
            
        default:
            
            println("\(indexPath.row) is selected");
            
        }
        
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        

        
        if (editingStyle == UITableViewCellEditingStyle.Delete){
            
            //
        
            //

           
            let entityDescription =
            NSEntityDescription.entityForName("Book",
                inManagedObjectContext: managedObjectContext!)
            
            let request = NSFetchRequest()
            request.entity = entityDescription
            var error: NSError?
            
            var objects = managedObjectContext?.executeFetchRequest(request,
                error: &error)
            
            
            
            
            if  var results = objects {
                
                
                if results.count > 0 {
                    let match = results[indexPath.row] as! NSManagedObject
                    
                    self.managedObjectContext?.deleteObject(match)
                    
                    match.managedObjectContext?.save(&error)
                   
                    viewDidLoad()
                     tableView.reloadData()
                    
                }
                
            }else{
                
                  println("error")
            }
            
            if objects!.count > 0{
                if objects!.count == 1{
                   setEditing(false, animated: true)
                    self.Minusbar.title = ""
                    self.Minusbar.image = UIImage(named: "")

                }else{
                    if Btclick == 1{
                         setEditing(true, animated: true)
                    }else{
                         setEditing(false, animated: true)
                    }
                  
                }}
            println("DELETED")
        }
    }




   override func setEditing (editing:Bool, animated:Bool)
    {
        super.setEditing(editing,animated:animated)
        if (self.editing) {
            
            self.navigationItem.rightBarButtonItem!.image = UIImage(named: "")
            self.navigationItem.rightBarButtonItem?.enabled = false
            self.Minusbar.title = "Done"
            self.Minusbar.image = UIImage(named: "")
            
        }
        else {
        
            self.navigationItem.rightBarButtonItem!.image = UIImage(named: "Add_icon")
            self.navigationItem.rightBarButtonItem?.enabled = true
            self.Minusbar.title = ""
            self.Minusbar.image = UIImage(named: "Minus_icon")
            
        }
    }
    
    @IBAction func deletebyswipe(sender: AnyObject) {
        
        if tableView.editing {
            setEditing(false, animated: true)
            Btclick = 0
            
        } else {
            Btclick = 1
            setEditing(true, animated: true)
           
        }
}
}