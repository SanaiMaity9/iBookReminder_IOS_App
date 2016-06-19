//
//  EditController.swift
//  Book
//
//  Created by Manish on 09/10/15.
//  Copyright (c) 2015 ifconit. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreData

class EditController: UITableViewController, UITextViewDelegate,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet var bknm: UITextField!
  
    @IBOutlet var isnm: UITextField!
    
    @IBOutlet var desa: UITextView!
    

    @IBOutlet var autnm: UITextField!

    @IBOutlet var bkshd: UIView!
    struct defaultsKeys {
        static let bkid = "bki"
    }
     var  k:NSNumber!
    
    @IBOutlet var imgb: UIImageView!
    var newMedia: Bool?

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     self.tabBarController?.tabBar.hidden = true
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 237/255, alpha: 1)
        
        //database coding
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let st = defaults.valueForKey(defaultsKeys.bkid) as? NSNumber! {
            k = st// Some String Value
        }
        
        
        //database coding
        
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
                
                bknm.text = match.valueForKey("title") as? String!
                autnm.text = match.valueForKey("author") as? String!
                isnm.text = match.valueForKey("isbn_no") as? String!
                desa.text = match.valueForKey("desption") as? String!
                var t = match.valueForKey("bookimg") as! NSData!
                imgb.image = UIImage(data: t)
              
                
                
            } else {
                
               
                println("No Match")
            }
            
        }
        

        
        
        
        //
        
        bkshd.layer.shadowOffset = CGSize(width: 3, height: 3)
        bkshd.layer.shadowOpacity = 0.7
        bkshd.layer.shadowRadius = 2
    
        self.bknm.delegate = self
        self.isnm.delegate = self
        self.autnm.delegate = self
       
        
        if imgb.image != UIImage(named: "") {
            
            
            
        }else{
            imgb.image = UIImage(named: "Noimg_icon")
            
        }
        // create tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapGesture:")
        
        // add it to the image view;
        imgb.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        imgb.userInteractionEnabled = true
        
        let numberToolbar = UIToolbar(frame: CGRectMake(0,0,320,50))
        numberToolbar.barStyle = UIBarStyle.Default
        numberToolbar.barTintColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
        numberToolbar.tintColor = UIColor.whiteColor()
        numberToolbar.items = [
            UIBarButtonItem(title: "Previous", style: UIBarButtonItemStyle.Plain, target: self, action: "PreTapped:"), UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: "NextTapped:"),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "DoneTapped:")]
        
        numberToolbar.sizeToFit()
       bknm.inputAccessoryView = numberToolbar
        
        self.desa.inputAccessoryView = numberToolbar
        self.isnm.inputAccessoryView = numberToolbar
        self.autnm.inputAccessoryView = numberToolbar
        
    }
    func PreTapped(textField: UITextField!)-> Bool{
      
        if(desa.isFirstResponder()){
          
            isnm.becomeFirstResponder()
            
        
        }
        
        else if(isnm.isFirstResponder()){
           
            autnm.becomeFirstResponder()
            
        }
        
       else if(autnm.isFirstResponder()){
           
            bknm.becomeFirstResponder()
            
        }
        
        else if(bknm.isFirstResponder()){
            
            bknm.becomeFirstResponder()
            
        }
        
        return true
    }
    
    func NextTapped(textField: UITextField!)-> Bool{
        
        if(bknm.isFirstResponder()){
            
            autnm.becomeFirstResponder()
            
            
        }
            
        else if(autnm.isFirstResponder()){
           
            isnm.becomeFirstResponder()
            
        }
            
        else if(isnm.isFirstResponder()){
           
            desa.becomeFirstResponder()
            
        }
            
        else if(desa.isFirstResponder()){
           
            desa.becomeFirstResponder()
            
        }
        
        return true
    }


    
    func DoneTapped(textField: UITextField){
          bknm.resignFirstResponder()
        autnm.resignFirstResponder()
        desa.resignFirstResponder()
        isnm.resignFirstResponder()
    }
    
    func tapGesture(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        println("tap")
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        // 2
        let deleteAction = UIAlertAction(title: "Choose from gallary", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Choose from gallary")
            if UIImagePickerController.isSourceTypeAvailable(
                UIImagePickerControllerSourceType.SavedPhotosAlbum) {
                    let imagePicker = UIImagePickerController()
                    
                    imagePicker.delegate = self
                    imagePicker.sourceType =
                        UIImagePickerControllerSourceType.PhotoLibrary
                    imagePicker.mediaTypes = [kUTTypeImage as NSString]
                    imagePicker.allowsEditing = false
                    self.presentViewController(imagePicker, animated: true,
                        completion: nil)
                    self.newMedia = false
            }

           
        })
        let saveAction = UIAlertAction(title: "Take from camera", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Take from camera")
            if UIImagePickerController.isSourceTypeAvailable(
                UIImagePickerControllerSourceType.Camera) {
                    
                    let imagePicker = UIImagePickerController()
                    
                    imagePicker.delegate = self
                    imagePicker.sourceType =
                        UIImagePickerControllerSourceType.Camera
                    imagePicker.mediaTypes = [kUTTypeImage as NSString]
                    imagePicker.allowsEditing = false
                    
                    self.presentViewController(imagePicker, animated: true,
                        completion: nil)
                    self.newMedia = true
            }

           
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Cancelled")
        })
        
        
        // 4
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 10
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false;
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if mediaType == (kUTTypeImage as! String) {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            
           imgb.image = image
            
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                    "image:didFinishSavingWithError:contextInfo:", nil)
            } else if mediaType == (kUTTypeMovie as! String) {
                // Code to support video here
            }
            
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafePointer<Void>) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                message: "Failed to save image",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                style: .Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true,
                completion: nil)
        }
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func updat(sender: AnyObject) {
        
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
                match.setValue(bknm.text as String!, forKey: "title")
                 match.setValue(autnm.text as String!, forKey: "author")
                 match.setValue(isnm.text as String!, forKey: "isbn_no")
                match.setValue(desa.text as String!, forKey: "desption")
                let image = imgb.image
                var r = NSData(data: UIImageJPEGRepresentation(image, 1.0))

                match.setValue(r as NSData!, forKey: "bookimg")
                
                
                managedObjectContext?.save(nil)
                
                
               
                println("updated")
                
                
                  var refreshAlert = UIAlertController(title: "iBook Reminder", message: "Book information has been updated successfully", preferredStyle: UIAlertControllerStyle.Alert)
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                     self.navigationController?.popViewControllerAnimated(true)
                }))
                
                presentViewController(refreshAlert, animated: true, completion: nil)
                

                
            } else {
                
                 println("error")
                
                var refreshAlert = UIAlertController(title: "iBook Reminder", message: "Book information has not been updated successfully", preferredStyle: UIAlertControllerStyle.Alert)
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                    self.navigationController?.popViewControllerAnimated(true)
                }))
                
                presentViewController(refreshAlert, animated: true, completion: nil)
            
               
            }
        }

        
    }
    
    
    
    @IBAction func dele(sender: AnyObject) {
        
        var refreshAlert = UIAlertController(title: "Do you want to delete this book?", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
            let entityDescription =
            NSEntityDescription.entityForName("Book",
                inManagedObjectContext: self.managedObjectContext!)
            
            let request = NSFetchRequest()
            request.entity = entityDescription
            var error: NSError?
            
            var objects = self.managedObjectContext?.executeFetchRequest(request,
                error: &error)
            
            
            var u = self.k as Int!
            
            if  var results = objects {
                
                
                if results.count > 0 {
                    let match = results[u] as! NSManagedObject
                    
                    self.managedObjectContext?.deleteObject(match)
                    
                    match.managedObjectContext?.save(&error)
                    
                    
                    println("deleted")
                    
                    self.navigationController?.popToRootViewControllerAnimated(true)
                }
                
            }else{
                
                println("error")
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: .Default, handler: { (action: UIAlertAction!) in
            
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        
        
        
        
        
    }
    
    
    

  }
