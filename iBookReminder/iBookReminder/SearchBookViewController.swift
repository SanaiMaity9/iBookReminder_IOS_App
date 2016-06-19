

import UIKit

class SearchBookViewController: UITableViewController,UITextFieldDelegate{

    @IBOutlet var bookName: UITextField!
    var id:String!
    
    @IBOutlet var authorName: UITextField!
    
    @IBOutlet var isbnNo: UITextField!
    
    
    
    struct defaultsKeys {
        static let book_name = "bknm"
        static let book_author = "bkau"
        static let book_isbn = "bkisbn"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.hidden = true
         navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
         id = UIDevice.currentDevice().identifierForVendor!.UUIDString
        //
        
        //
        
       
       
        
        self.tableView.tableFooterView = UIView()
        
        self.bookName.delegate = self
        self.authorName.delegate = self
        self.isbnNo.delegate = self
        
        
        
        let numberToolbar = UIToolbar(frame: CGRectMake(0,0,320,30))
        
        numberToolbar.barStyle = UIBarStyle.Default
        numberToolbar.barTintColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
        numberToolbar.tintColor = UIColor.whiteColor()
        numberToolbar.items = [
            UIBarButtonItem(title: "Previous", style: UIBarButtonItemStyle.Plain, target: self, action: "PreTapped:"), UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: "NextTapped:"),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "DoneTapped:")]
        
        numberToolbar.sizeToFit()
                
        self.bookName.inputAccessoryView = numberToolbar
        self.authorName.inputAccessoryView = numberToolbar
        self.isbnNo.inputAccessoryView = numberToolbar

           }
    
    func PreTapped(textField: UITextField!)-> Bool{
        
       
            
         if(isbnNo.isFirstResponder()){
            
           authorName.becomeFirstResponder()
            
        }
            
        else if(authorName.isFirstResponder()){
            
            bookName.becomeFirstResponder()
            
        }
            
        else if(bookName.isFirstResponder()){
            
            bookName.becomeFirstResponder()
            
        }
        
        return true
    }
    
    func NextTapped(textField: UITextField!)-> Bool{
        
        if(bookName.isFirstResponder()){
            
            authorName.becomeFirstResponder()
            
            
        }
            
        else if(authorName.isFirstResponder()){
            
            isbnNo.becomeFirstResponder()
            
        }
            
        else if(isbnNo.isFirstResponder()){
            
            isbnNo.becomeFirstResponder()
            
        }
            
        
        
        return true
    }
    
    
    
    func DoneTapped(textField: UITextField){
        bookName.resignFirstResponder()
        authorName.resignFirstResponder()
        isbnNo.resignFirstResponder()
       
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false;
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 6
    }

    @IBAction func searchbook(sender: AnyObject) {
        
        if bookName.text == "" && authorName.text == "" && isbnNo.text == ""{
            var refreshAlert = UIAlertController(title: "iBook Reminder", message: "Enter any one field to search  book ", preferredStyle: UIAlertControllerStyle.Alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                
            }))
            
             presentViewController(refreshAlert, animated: true, completion: nil)
            
        }else{
        
        var bk = self.bookName.text as String
        var ak = self.authorName.text as String
        var ibn = self.isbnNo.text as String
       println("http://52.88.165.30/ibookreminder/WS/services.php?mode=search_book&title=\(bk)&author=\(ak)&isbn=\(ibn)&device_id=\(id)")
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setValue(bk, forKey: defaultsKeys.book_name)
        defaults.setValue(ak, forKey: defaultsKeys.book_author)
        defaults.setValue(ibn, forKey: defaultsKeys.book_isbn)
        
        self.performSegueWithIdentifier("details", sender: self)
        }
    }
}
