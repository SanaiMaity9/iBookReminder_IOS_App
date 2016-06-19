

import UIKit

class SearchController: UIViewController {

    
    @IBOutlet var ti3: UIImageView!
    
    @IBOutlet var ti1: UIImageView!
    
    @IBOutlet var ti2: UIImageView!
    
    @IBOutlet var bt1: UIButton!
  
    
    @IBOutlet var srvw: UIView!
    
    @IBOutlet var bt3: UIButton!
    
    @IBOutlet var bt2: UIButton!
    
    
    @IBOutlet var srch: UISearchBar!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
       
       srch.barTintColor = UIColor(red: 80/255, green: 16/255, blue: 42/255, alpha: 1)
        
        
        srvw.hidden = true
        ti1.hidden = true
        ti2.hidden = true
        ti3.hidden = true

       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func titl(sender: AnyObject) {
        
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
    
   

}
