
import UIKit
import CoreData


class FavoriteViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet var ti3: UIImageView!
    @IBOutlet var ti1: UIImageView!
    @IBOutlet var ti2: UIImageView!
    @IBOutlet var bt1: UIButton!
    @IBOutlet var srvw: UIView!
    @IBOutlet var bt3: UIButton!
    @IBOutlet var bt2: UIButton!
    
    @IBOutlet var srch: UISearchBar!
    //tableview
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet var tableview: UITableView!
    
    var counter = 0;
    @IBOutlet var Minusbar: UIBarButtonItem!
    var people = [NSManagedObject]()
    var label: UILabel!
    var  emcell:UITableViewCell!
    var lbvw:UIView!
    var ig:String!
    var sln = [Int]()
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
    //search
    var searchActive : Bool = false
    var filtered:[String] = []
    var bookTitle:[String] = []
    var selectedIndex = 1;
    var bookName:[String] = []
    var bookAuthor:[String] = []
    var bookIsbn:[String] = []
    var res = [Int]()
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //
       
        
        //
        
        tableview.delegate = self
        tableview.dataSource = self
        srch.delegate = self
        
        srch.barTintColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
        bt1.titleLabel?.textColor = UIColor(red: 68/255, green: 40/255, blue: 53/255, alpha: 1)
        bt1.backgroundColor = UIColor.whiteColor()
        bt1.layer.cornerRadius = 15.0
        bt1.setTitleColor(UIColor(red: 68/255, green: 40/255, blue: 53/255, alpha: 1), forState: UIControlState.Normal)
        srch.placeholder = "Enter Book Title"
        srvw.hidden = false
        ti1.hidden = false
        ti2.hidden = true
        ti3.hidden = true
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
        
        
        
        
        for var i=0; i<objects!.count; i++
        {
            
            if  var results = objects {
                
                
                if results.count > 0 {
                    var match = results[i] as! NSManagedObject
                    var fav = match.valueForKey("fav") as! NSNumber!
                    var name = match.valueForKey("title") as! String!
                    var author = match.valueForKey("author") as! String!
                    var isbn = match.valueForKey("isbn_no") as! String!
                    
                    if contains(bookName, name){
                        
                    }else{
                        
                        bookName.append(name)
                    }
                    
                    if contains(bookAuthor, author){
                        
                    }else{
                        
                        bookAuthor.append(author)
                    }
                    
                    if contains(bookIsbn, isbn){
                        
                    }else{
                        
                        bookIsbn.append(isbn)
                    }
                    
                    if contains(sln, i){
                        
                    }else{
                        
                        sln.append(i)
                    }
                    
                    if fav == Optional(1){
                        
                        
                    }else{
                        if let index = find(sln, i) {
                            sln.removeAtIndex(index)
                        }
                        
                    }
                    
                }
                
            }else{
                
                println("error")
            }
        }
        
        println(bookName)
        
        //
        label = UILabel(frame: CGRectMake(0, 0, 300, 100))
        
        if sln.count > 0 {
            label.hidden = true
            // var label = UILabel(frame: CGRectMake(0, 0, 300, 100))
            let subViews = self.view.subviews
            for subview in subViews{
                if subview.tag == 999 {
                    subview.removeFromSuperview()
                    
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
            
            self.Minusbar.title = ""
            self.Minusbar.image = UIImage(named: "")
            self.Minusbar.enabled = false
            
            //
            
            label.center = CGPointMake(150, 220)
            label.textColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
            
            label.font = UIFont (name: "HelveticaNeue-Thin", size: 19)
            label.numberOfLines = 3
            label.tag = 999
            label.textAlignment = NSTextAlignment.Center
            label.text = " No favourite found."
            
            self.view.addSubview(label)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
    }
    
    
    @IBAction func titl(sender: AnyObject) {
        
        self.selectedIndex = 1
        bookTitle.removeAll(keepCapacity: true)
        sender.setTitleColor(UIColor(red: 68/255, green: 40/255, blue: 53/255, alpha: 1), forState: UIControlState.Normal)
        
        bt1.backgroundColor = UIColor.whiteColor()
        bt1.layer.cornerRadius = 15.0
        
        bt2.backgroundColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
        
        bt2.titleLabel?.textColor = UIColor.whiteColor()
        bt2.layer.cornerRadius = 0
        
        bt3.backgroundColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
        bt3.titleLabel?.textColor = UIColor.whiteColor()
        bt3.layer.cornerRadius = 0
        
        srch.placeholder = "Enter Book Title"
        
        
        ti1.hidden = false
        ti2.hidden = true
        ti3.hidden = true
        
        
        srvw.hidden = false
        
        
    }
    
    
    
    @IBAction func authr(sender: AnyObject) {
        
        self.selectedIndex = 2
        bookTitle.removeAll(keepCapacity: true)
        sender.setTitleColor(UIColor(red: 68/255, green: 40/255, blue: 53/255, alpha: 1), forState: UIControlState.Normal)
        
        bt2.backgroundColor = UIColor.whiteColor()
        bt2.layer.cornerRadius = 15.0
        
        bt1.backgroundColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
        bt1.titleLabel?.textColor = UIColor.whiteColor()
        bt1.layer.cornerRadius = 0
        
        bt3.backgroundColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
        bt3.titleLabel?.textColor = UIColor.whiteColor()
        bt3.layer.cornerRadius = 0
        
        srch.placeholder = "Enter Book's Author"
        
        
        ti2.hidden = false
        ti1.hidden = true
        ti3.hidden = true
        
        
        srvw.hidden = false
        
    }
    
    
    
    
    @IBAction func ISBN(sender: AnyObject) {
        
        
        
        self.selectedIndex = 3
        bookTitle.removeAll(keepCapacity: true)
        sender.setTitleColor(UIColor(red: 68/255, green: 40/255, blue: 53/255, alpha: 1), forState: UIControlState.Normal)
        
        bt3.backgroundColor = UIColor.whiteColor()
        bt3.layer.cornerRadius = 15.0
        
        bt2.backgroundColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
        bt2.titleLabel?.textColor = UIColor.whiteColor()
        bt2.layer.cornerRadius = 0
        
        bt1.backgroundColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
        bt1.titleLabel?.textColor = UIColor.whiteColor()
        bt1.layer.cornerRadius = 0
        srch.placeholder = "Enter Book's ISBN No."
        
        ti3.hidden = false
        ti1.hidden = true
        ti2.hidden = true
        
        
        srvw.hidden = false
        
    }
    //tableview coding
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.searchActive = false
        bt1.backgroundColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
        bt1.titleLabel?.textColor = UIColor.whiteColor()
        bt1.layer.cornerRadius = 0
        
        bt2.backgroundColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
        bt2.titleLabel?.textColor = UIColor.whiteColor()
        bt2.layer.cornerRadius = 0
        
        bt3.backgroundColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
        bt3.titleLabel?.textColor = UIColor.whiteColor()
        bt3.layer.cornerRadius = 0
        self.searchActive = false
        self.selectedIndex = 1
        self.bookTitle.removeAll(keepCapacity: true)
        srch.showsCancelButton = false
        srch.text = ""
        
        self.filtered.removeAll(keepCapacity: true)
        self.res.removeAll(keepCapacity: true)
        sln.removeAll(keepCapacity: true)
        viewDidLoad()
        tableview.reloadData()
        
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! FristviewCell
        
        if filtered.count == 0{
            self.searchActive = false
        }
        
        if (searchActive == true){
            
            switch(self.selectedIndex)
            {
                
            case 1 :
                
                var f = filtered[indexPath.row]
                
                res += bookName.indexesOf3("\(f)")
                
                println(res)
                //
                let entityDescription =
                NSEntityDescription.entityForName("Book",
                    inManagedObjectContext: managedObjectContext!)
                
                let request = NSFetchRequest()
                request.entity = entityDescription
                var error: NSError?
                
                var objects = managedObjectContext?.executeFetchRequest(request,
                    error: &error)
                for var i=0; i<res.count; i++
                    
                {
                    if  var results = objects {
                        
                        var match = results[res[indexPath.row]] as! NSManagedObject
                        
                        cell.bknmm.text = filtered[indexPath.row]
                        
                        
                        cell.authornm.text =  match.valueForKey("author") as! String!
                        var k = match.valueForKey("bookimg") as! NSData!
                        cell.bki.image = UIImage(data: k)
                        
                        
                    } else {
                        println("No Match")
                    }
                    
                    
                }
                
                
                return cell
                
                break;
                
                
            case 2:
                
                
                var f = filtered[indexPath.row]
                
                res += bookAuthor.indexesOf3("\(f)")
                println(res)
                //
                let entityDescription =
                NSEntityDescription.entityForName("Book",
                    inManagedObjectContext: managedObjectContext!)
                
                let request = NSFetchRequest()
                request.entity = entityDescription
                var error: NSError?
                
                var objects = managedObjectContext?.executeFetchRequest(request,
                    error: &error)
                for var i=0; i<res.count; i++
                    
                {
                    if  var results = objects {
                        
                        var match = results[res[indexPath.row]] as! NSManagedObject
                        
                        cell.bknmm.text = match.valueForKey("title") as! String!
                        
                        
                        cell.authornm.text =  filtered[indexPath.row]
                        var k = match.valueForKey("bookimg") as! NSData!
                        cell.bki.image = UIImage(data: k)
                        
                        
                    } else {
                        println("No Match")
                    }
                    
                    
                }
                
                return cell
                
                
                break;
                
            case 3:
                
                
                var f = filtered[indexPath.row]
                
                res += bookIsbn.indexesOf3("\(f)")
                
                //
                let entityDescription =
                NSEntityDescription.entityForName("Book",
                    inManagedObjectContext: managedObjectContext!)
                
                let request = NSFetchRequest()
                request.entity = entityDescription
                var error: NSError?
                
                var objects = managedObjectContext?.executeFetchRequest(request,
                    error: &error)
                for var i=0; i<res.count; i++
                    
                {
                    if  var results = objects {
                        
                        var match = results[res[indexPath.row]] as! NSManagedObject
                        
                        cell.bknmm.text = match.valueForKey("title") as! String!
                        
                        
                        cell.authornm.text =  match.valueForKey("author") as! String!
                        var k = match.valueForKey("bookimg") as! NSData!
                        cell.bki.image = UIImage(data: k)
                        
                        
                    } else {
                        println("No Match")
                    }
                    
                    
                }
                
                return cell
                
                
                break;
                
                
            default:
                println("No selection")
            }
            
            
        }else {
            
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
                
                println(sln[indexPath.row])
                
                var match = results[sln[indexPath.row]] as! NSManagedObject
                
                var fav = match.valueForKey("fav") as! NSNumber!
                
                if fav == Optional(1){
                    cell.bknmm.text = match.valueForKey("title") as! String!
                    
                    
                    cell.authornm.text =  match.valueForKey("author") as! String!
                    var k = match.valueForKey("bookimg") as! NSData!
                    cell.bki.image = UIImage(data: k)
                    
                }
                
                
            }else {
                println("NO data")
            }
            
            
            return cell
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }else{
            
            return sln.count
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if filtered.count == 0{
            self.searchActive = false
        }
        
        switch(indexPath.row)
        {
            
        case 0...indexPath.row :
            if searchActive{
                
                     self.performSegueWithIdentifier("info4", sender: self)
                
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
                    
                    
                    var e = res[indexPath.row] as NSNumber!
                    let defaults = NSUserDefaults.standardUserDefaults()
                    
                    defaults.setValue(e, forKey: defaultsKeys.bkid)
                    
                    
                } else {
                    println("No Match")
                }
                
                
            }else{
                self.performSegueWithIdentifier("info4", sender: self)
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
                    
                    
                    
                    var e = sln[indexPath.row] as NSNumber!
                    
                    let defaults = NSUserDefaults.standardUserDefaults()
                    
                    defaults.setValue(e, forKey: defaultsKeys.bkid)
                    
                }
            }
            break;
            
            
        default:
            
            println("\(indexPath.row) is selected");
        }
        
        
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        if (editingStyle == UITableViewCellEditingStyle.Delete){
            
            //
            if searchActive{
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
                        let match = results[res[indexPath.row]] as! NSManagedObject
                        
                        self.managedObjectContext?.deleteObject(match)
                        
                        match.managedObjectContext?.save(&error)
                        
                        res.removeAll(keepCapacity: true)
                        self.searchActive = false
                        self.srch.endEditing(true)
                        self.srch.text = ""
                        srch.showsCancelButton = false
                        viewDidLoad()
                        self.tableview.reloadData()
                        
                    }
                    
                }else{
                    
                    println("error")
                }
                
            }else{
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
                        
                        res.removeAll(keepCapacity: true)
                        viewDidLoad()
                        self.tableview.reloadData()
                        
                    }
                    
                }else{
                    
                    println("error")
                }
                
            }
            
            res.removeAll(keepCapacity: true)
            filtered.removeAll(keepCapacity: true)
            sln.removeAll(keepCapacity: true)
            viewWillAppear(true)
            println("DELETED")
        }
    }
    
    
    
    
    override func setEditing (editing:Bool, animated:Bool)
    {
        super.setEditing(editing,animated:animated)
        if (self.editing) {
            
            
            self.Minusbar.title = "Done"
            self.Minusbar.image = UIImage(named: "")
            
        }
        else {
            
            self.Minusbar.title = ""
            self.Minusbar.image = UIImage(named: "Minus_icon")
            
        }
    }
    
    @IBAction func deletebyswipe(sender: AnyObject) {
        
        if self.counter == 0{
            self.tableview.setEditing(true, animated: true)
            setEditing(true, animated: true)
            self.counter = 1
            Btclick = 1
        }else{
            self.tableview.setEditing(false, animated: false)
            setEditing(false, animated: false)
            self.counter = 0
            Btclick = 0
        }
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true);
        srch.showsCancelButton = false
        srch.text = ""
        searchActive = false;
        bookTitle.removeAll(keepCapacity: true)
        if self.bt1.backgroundColor == UIColor.whiteColor(){
            
            self.bt2.backgroundColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
            self.bt2.titleLabel?.textColor = UIColor.whiteColor()
            self.bt2.layer.cornerRadius = 0
            
            self.bt3.backgroundColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
            self.bt3.titleLabel?.textColor = UIColor.whiteColor()
            self.bt3.layer.cornerRadius = 0
            
        }else if self.bt2.backgroundColor == UIColor.whiteColor(){
            
            self.bt1.backgroundColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
            self.bt1.titleLabel?.textColor = UIColor.whiteColor()
            self.bt1.layer.cornerRadius = 0
            
            self.bt3.backgroundColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
            self.bt3.titleLabel?.textColor = UIColor.whiteColor()
            self.bt3.layer.cornerRadius = 0
            
        }else if self.bt3.backgroundColor == UIColor.whiteColor() {
            
            self.bt1.backgroundColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
            self.bt1.titleLabel?.textColor = UIColor.whiteColor()
            self.bt1.layer.cornerRadius = 0
            
            self.bt2.backgroundColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
            self.bt2.titleLabel?.textColor = UIColor.whiteColor()
            self.bt2.layer.cornerRadius = 0
            
        }

        self.tableview.reloadData()
        
    }
    
    
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        srch.showsCancelButton = true
        searchActive = true
        
        
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
        bookTitle.removeAll(keepCapacity: true)
        self.view.endEditing(true);
        srch.showsCancelButton = false
        
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false
        bookTitle.removeAll(keepCapacity: true)
        srch.showsCancelButton = false
        self.view.endEditing(true);
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        switch(self.selectedIndex)
        {
            
        case 1 :
            self.res.removeAll(keepCapacity: true)
            let entityDescription =
            NSEntityDescription.entityForName("Book",
                inManagedObjectContext: managedObjectContext!)
            
            let request = NSFetchRequest()
            request.entity = entityDescription
            var error: NSError?
            
            var objects = managedObjectContext?.executeFetchRequest(request,
                error: &error)
            for var i=0; i<objects!.count; i++
            {
                if  var results = objects {
                    
                    
                    if results.count > 0 {
                        var match = results[i] as! NSManagedObject
                        var fav = match.valueForKey("fav") as! NSNumber!
                        
                        if fav == Optional(1){
                            var name = match.valueForKey("title") as! String!
                            
                            if contains(bookTitle, name){
                                
                            }else{
                                
                                bookTitle.append(name)
                            }
                            
                        }
                        
                    }
                }else {
                    println("No Match")
                }
            }
            
            println(bookTitle)
            
            
            filtered = bookTitle.filter({ (text) -> Bool in
                let tmp: NSString = text
                let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
                return range.location != NSNotFound
            })
            
            println(filtered)
            
            if(filtered.count == 0){
                searchActive = false;
            } else {
                searchActive = true;
            }
            self.tableview.reloadData()
            
            break;
            
        case 2:
            self.res.removeAll(keepCapacity: true)
            let entityDescription =
            NSEntityDescription.entityForName("Book",
                inManagedObjectContext: managedObjectContext!)
            
            let request = NSFetchRequest()
            request.entity = entityDescription
            var error: NSError?
            
            var objects = managedObjectContext?.executeFetchRequest(request,
                error: &error)
            for var i=0; i<objects!.count; i++
            {
                if  var results = objects {
                    
                    
                    if results.count > 0 {
                        var match = results[i] as! NSManagedObject
                        var fav = match.valueForKey("fav") as! NSNumber!
                        
                        if fav == Optional(1){
                            var name = match.valueForKey("author") as! String!
                            
                            if contains(bookTitle, name){
                                
                            }else{
                                
                                bookTitle.append(name)
                            }
                            
                        }
                        
                    }
                }else {
                    println("No Match")
                }
            }
            
            
            filtered = bookTitle.filter({ (text) -> Bool in
                let tmp: NSString = text
                let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
                return range.location != NSNotFound
            })
            
            println(filtered)
            
            if(filtered.count == 0){
                searchActive = false;
            } else {
                searchActive = true;
            }
            self.tableview.reloadData()
            
            break;
            
        case 3:
            self.res.removeAll(keepCapacity: true)
            let entityDescription =
            NSEntityDescription.entityForName("Book",
                inManagedObjectContext: managedObjectContext!)
            
            let request = NSFetchRequest()
            request.entity = entityDescription
            var error: NSError?
            
            var objects = managedObjectContext?.executeFetchRequest(request,
                error: &error)
            for var i=0; i<objects!.count; i++
            {
                if  var results = objects {
                    
                    
                    if results.count > 0 {
                        var match = results[i] as! NSManagedObject
                        var fav = match.valueForKey("fav") as! NSNumber!
                        
                        if fav == Optional(1){
                            var name = match.valueForKey("isbn_no") as! String!
                            
                            if contains(bookTitle, name){
                                
                            }else{
                                
                                bookTitle.append(name)
                            }
                            
                        }
                        
                    }
                }else {
                    println("No Match")
                }
            }
            
            
            
            filtered = bookTitle.filter({ (text) -> Bool in
                let tmp: NSString = text
                let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
                return range.location != NSNotFound
            })
            
            println(filtered)
            
            if(filtered.count == 0){
                searchActive = false;
            } else {
                searchActive = true;
            }
            self.tableview.reloadData()
            
            break;
            
            
        default:
            println("No selection")
        }
    }
    
    
}


extension Array {
    func indexesOf3<T : Equatable>(object:T) -> [Int] {
        var result: [Int] = []
        for (index,obj) in enumerate(self) {
            if obj as! T == object {
                result.append(index)
            }
        }
        return result
    }
    
}
