import UIKit
import Foundation

class ActivityIndicatorView
{
    var view: UIView!
    
    var activityIndicator: UIActivityIndicatorView!
    
    var title: String!
    
    init(title: String, center: CGPoint, width: CGFloat = 50.0, height: CGFloat = 50.0)
    {
        self.title = title
        
        let x = center.x - width/2
        let y = center.y - height
        
        self.view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        self.view.backgroundColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 0.5)
        self.view.layer.cornerRadius = 10
        
        self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        self.activityIndicator.color = UIColor.blackColor()
        self.activityIndicator.hidesWhenStopped = false
        
        
        self.view.addSubview(self.activityIndicator)
       
           }
    
    func getViewActivityIndicator() -> UIView
    {
        return self.view
    }
    
    func startAnimating()
    {
        self.activityIndicator.startAnimating()
       // UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    func stopAnimating()
    {
        self.activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
        self.view.removeFromSuperview()
 }
}