
import UIKit
import CoreData

class CustomAlertViewController : UIViewController {
    var transitioner : CAVTransitioner
    
    @IBOutlet var done: UIButton!
    
    @IBOutlet var cancel: UIButton!
    var bookinfo:BookInfoController!
    @IBOutlet var floatRatingView: FloatRatingView!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    //k= index  of book selected
    var  k:NSNumber!
    struct defaultsKeys {
        static let bkid = "bki"

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        done.layer.cornerRadius = 3
        cancel.layer.cornerRadius = 3
        
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        self.transitioner = CAVTransitioner()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .Custom
        self.transitioningDelegate = self.transitioner

    }
    
    convenience init() {
        self.init(nibName:"CustomAlertViewController", bundle:nil)
    
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    @IBAction func doDismiss(sender:AnyObject?) {
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func save(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let st = defaults.valueForKey(defaultsKeys.bkid) as? NSNumber! {
            k = st// Some String Value
        }
        
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
          
                
                match.setValue(self.floatRatingView.rating, forKey: "rating")
                managedObjectContext?.save(nil)
          
             NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)                
            self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
                
            }

            
        }
        
        
        
    }
    
    
 
}