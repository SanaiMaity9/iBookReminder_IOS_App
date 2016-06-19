

import UIKit
import MobileCoreServices
import CoreData


class AddNewController: UITableViewController, UITextViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    let managedObjectContext =
    (UIApplication.sharedApplication().delegate
        as! AppDelegate).managedObjectContext
    var ch = [AnyObject]()
     var newMedia: Bool?
    var im = [UIImage]()
    var e:String!
    
    @IBOutlet var emfr: UIView!
    
    @IBOutlet var frm: UIView!
    var id:Int!
    @IBOutlet var imgg: UIImageView!
    @IBOutlet var bknme: UITextField!
    @IBOutlet var Authrnme: UITextField!
    @IBOutlet var isbn: UITextField!
    @IBOutlet var textView: UITextView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
      self.tabBarController?.tabBar.hidden = true
        
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

        //self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 237/255, alpha: 1)
        
        textView.delegate = self
        textView.text = "Write something about your favourite book..."
        textView.textColor = UIColor.lightGrayColor()
       
      
        bknme.delegate = self
         Authrnme.delegate = self
         isbn.delegate = self
        imgg.hidden = false
   
      
        frm.layer.shadowColor = UIColor.blackColor().CGColor
        frm.layer.shadowOffset = CGSize(width: 0, height: 2)
        frm.layer.shadowOpacity = 0.4
        frm.layer.shadowRadius = 5
        
        if imgg.image != UIImage(named: "") {
            
            
       
        }else{
            imgg.image = UIImage(named: "Noimg_icon")
      }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapGesture:")
        
        // add it to the image view;
     self.imgg.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        self.imgg.userInteractionEnabled = true

        let numberToolbar = UIToolbar(frame: CGRectMake(0,0,320,30))
        
        numberToolbar.barStyle = UIBarStyle.Default
        numberToolbar.barTintColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
        numberToolbar.tintColor = UIColor.whiteColor()
        numberToolbar.items = [
            UIBarButtonItem(title: "Previous", style: UIBarButtonItemStyle.Plain, target: self, action: "PreTapped:"), UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: "NextTapped:"),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "DoneTapped:")]
        
        numberToolbar.sizeToFit()
       bknme.inputAccessoryView = numberToolbar
        
        self.Authrnme.inputAccessoryView = numberToolbar
        self.isbn.inputAccessoryView = numberToolbar
        self.textView.inputAccessoryView = numberToolbar
        
        
        
        //
        
        
        //
        
        
        
    }
    func PreTapped(textField: UITextField!)-> Bool{
        
        if(textView.isFirstResponder()){
            
            isbn.becomeFirstResponder()
            
            
        }
            
        else if(isbn.isFirstResponder()){
            
           Authrnme.becomeFirstResponder()
            
        }
            
        else if(Authrnme.isFirstResponder()){
            
        bknme.becomeFirstResponder()
            
        }
            
        else if(bknme.isFirstResponder()){
            
            bknme.becomeFirstResponder()
            
        }
        
        return true
    }
    
    func NextTapped(textField: UITextField!)-> Bool{
        
        if(bknme.isFirstResponder()){
            
            Authrnme.becomeFirstResponder()
            
            
        }
            
        else if(Authrnme.isFirstResponder()){
            
            isbn.becomeFirstResponder()
            
        }
            
        else if(isbn.isFirstResponder()){
            
            textView.becomeFirstResponder()
            
        }
            
        else if(textView.isFirstResponder()){
            
            textView.becomeFirstResponder()
            
        }
        
        return true
    }
    
    
    
    func DoneTapped(textField: UITextField){
        bknme.resignFirstResponder()
        Authrnme.resignFirstResponder()
        isbn.resignFirstResponder()
        textView.resignFirstResponder()
    }
    

    
   func tapGesture(gesture: UIGestureRecognizer) {
    println("tap")
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        
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
        return 8
    }
    func textViewDidBeginEditing(textView: UITextView) {
       
      
    
        if  textView.text == "" || textView.text == "Write something about your favourite book..."{
            textView.text = ""
            textView.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        
        }else{
           
            textView.text + textView.text
            textView.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        }
        
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write something about your favourite book..."
            textView.textColor = UIColor.lightGrayColor()
        }else{
            
            println("not empty")
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        switch(indexPath.row)
        {
            
        case 1:
            bknme.becomeFirstResponder()
           
            break;
            
        case 2:
            Authrnme.becomeFirstResponder()
            
            break;

        case 3:
            isbn.becomeFirstResponder()
            
            break;

            
        default:
            
            println("pls select");
            
        }
        
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false;
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        mediaType.lastPathComponent
        self.dismissViewControllerAnimated(true, completion: nil)
        
       
        
        if mediaType == (kUTTypeImage as! String) {
            let image = info[UIImagePickerControllerOriginalImage]
            
                as! UIImage
            //
           
            
            //
            imgg.image = image
            
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

   
    
    
    @IBAction func Save(sender: AnyObject) {
        
        if bknme.text == "" || Authrnme.text == "" || isbn.text == "" || textView.text == ""{
            
            if bknme.text == ""{
                
            var refreshAlert = UIAlertController(title: "iBook Reminder", message: "Enter the book name", preferredStyle: UIAlertControllerStyle.Alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                bknme.becomeFirstResponder()
            }))
            
             presentViewController(refreshAlert, animated: true, completion: nil)
            }
            else if Authrnme.text == ""{
                
                var refreshAlert = UIAlertController(title: "iBook Reminder", message: "Enter book author name", preferredStyle: UIAlertControllerStyle.Alert)
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                    Authrnme.becomeFirstResponder()
                }))
                
                presentViewController(refreshAlert, animated: true, completion: nil)
                
            }
            else if isbn.text == ""{
                
                var refreshAlert = UIAlertController(title: "iBook Reminder", message: "Enter book ISBN no", preferredStyle: UIAlertControllerStyle.Alert)
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                    isbn.becomeFirstResponder()
                }))
                
                presentViewController(refreshAlert, animated: true, completion: nil)
                
            }
            else if textView.text == ""{
                
                var refreshAlert = UIAlertController(title: "iBook Reminder", message: "Enter book description", preferredStyle: UIAlertControllerStyle.Alert)
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                    textView.becomeFirstResponder()
                }))
                
                presentViewController(refreshAlert, animated: true, completion: nil)
                
            }
        
        }else{
            
        let entityDescription =
        NSEntityDescription.entityForName("Book",
            inManagedObjectContext: managedObjectContext!)
        
        let book = Book(entity: entityDescription!,
            insertIntoManagedObjectContext: managedObjectContext)

        book.title = bknme.text
        book.author = Authrnme.text
        book.isbn_no = isbn.text
        book.desption = textView.text
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
  
  
}

    
    

