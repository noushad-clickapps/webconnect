//
//  NotificationeMessageView.swift
//  NotificationMessageView
//
//  Created by Aman Aggarwal on 3/1/17.
//  Copyright © 2017 ClickApps. All rights reserved.
//

import UIKit


struct directions {
    
    static let fromUp = 1
    static let fromDown = 2
}

class NotificationView: UIView {
    
    var messageLable : UILabel!
    private var directionOFNotificationView: Int = 1
    static let shared = NotificationView()
    
    private func initWithView()  {
        
        if messageLable == nil {
            
            messageLable = UILabel.init(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 50.0))
            messageLable.textColor = UIColor.white
            messageLable.font = UIFont.boldSystemFont(ofSize: 15.0)
            messageLable.textAlignment = .center
            messageLable.numberOfLines = 0
            self.backgroundColor = UIColor.yellow
            var frame = messageLable.frame
            frame.size.height = CGFloat(returnHeightForLable(messageLable, andWidthGap: 0)) + CGFloat(60.0)
            messageLable.frame = frame
            self.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: frame.size.height)
            self.addSubview(messageLable)
            addShadowToView(vw:self)
        }
    }

    
    func showOnView(_ view:UIView, with message: String,ofType type:NotificationMessageType ,andDirection direction: Int )  {
        
         DispatchQueue.main.async {
        
        self.initWithView()
        
        self.removeFromSuperview()
        
        self.messageLable.text = message
        self.messageLable.frame.size.height = CGFloat(self.returnHeightForLable(self.messageLable, andWidthGap: 0)) + CGFloat(60.0)
        self.directionOFNotificationView = direction
        self.frame.size.height = self.messageLable.frame.size.height
        self.backgroundColor = UIColor(red: 255.0/255.0, green: 180.0/255.0, blue: 19.0/255.0, alpha: 1.0)
        
        switch type {
            
        case NotificationMessageType.Success:
            self.backgroundColor = Colors.kGreenColor
            break
            
        case NotificationMessageType.Error:
            self.backgroundColor = Colors.kErrorCodeColor
            break
            
        case NotificationMessageType.Warning:
            self.backgroundColor = UIColor(red: 216.0/255.0, green: 77.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            break
            
        default:
            //self.backgroundColor = UIColor(red: 52.0/255.0, green: 202.0/255.0, blue: 108.0/255.0, alpha: 1.0)
            break
        }
        
        if self.directionOFNotificationView == directions.fromUp {
            
            self.frame = CGRect(x: 0.0, y: -400.0, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
        }
        else if self.directionOFNotificationView == directions.fromDown {
            
            self.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height + 500, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
        }
        
        view.addSubview(self)
        self.perform(#selector(self.showViewWithAnimation), with: nil, afterDelay: 0.2)
        }
    }
    
    func showViewWithoutDismiss(with message: String?,ofType type:NotificationMessageType ,andDirection direction: Int )  {
        
        DispatchQueue.main.async {
        
        //self.initWithView()
        
       // self.removeFromSuperview()
        
            self.initWithView()
            if message != nil {
                
                self.messageLable.text = message
            }
        self.messageLable.frame.size.height = CGFloat(self.returnHeightForLable(self.messageLable, andWidthGap: 0)) + CGFloat(60.0)
        self.directionOFNotificationView = direction
        self.frame.size.height = self.messageLable.frame.size.height
        self.backgroundColor = UIColor(red: 255.0/255.0, green: 180.0/255.0, blue: 19.0/255.0, alpha: 1.0)
        
        switch type {
        
        case NotificationMessageType.Success:
        self.backgroundColor = UIColor(red: 52.0/255.0, green: 202.0/255.0, blue: 108.0/255.0, alpha: 1.0)
        break
        
        case NotificationMessageType.Error:
        self.backgroundColor = UIColor(red: 216.0/255.0, green: 77.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        case NotificationMessageType.Warning:
        self.backgroundColor = UIColor(red: 216.0/255.0, green: 77.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        default:
        //self.backgroundColor = UIColor(red: 52.0/255.0, green: 202.0/255.0, blue: 108.0/255.0, alpha: 1.0)
        break
        }
        
        if self.directionOFNotificationView == directions.fromUp {
        
        self.frame = CGRect(x: 0.0, y: -400.0, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
        }
        else if self.directionOFNotificationView == directions.fromDown {
        
        self.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height + 500, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
        }
        
        App_Delegate.window?.addSubview(self)
            
            UIView.animate(withDuration: 0.5, animations: { 
                
                self.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
            })
        }
    }

    
    func showViewWithAnimation() {
        
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
            
            if self.directionOFNotificationView == directions.fromUp {
                
                self.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
            }
            else if self.directionOFNotificationView == directions.fromDown {
                
                self.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - self.frame.size.height, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
            }
            
        }) { (animated:Bool) in
            self.perform(#selector(self.hideNotificationView), with: nil, afterDelay: 0.3)
        }
    }
    
    func hideNotificationView () {
        
        UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseIn, animations: {
            
            if self.directionOFNotificationView == directions.fromUp {
                
                self.frame = CGRect(x: 0.0, y: -self.frame.size.height, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
            }
            else if self.directionOFNotificationView == directions.fromDown {
                
                self.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height + 500, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
            }
            
        }) { (animated:Bool) in
        }
    }
    
    func returnHeightForLable(_ lable: UILabel, andWidthGap gap:Float) -> Float {
        
        let str = String(describing: lable.text)
        let frame = str.boundingRect(with: CGSize(width: UIScreen.main.bounds.size.width - CGFloat(gap), height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: lable.font], context: nil)
        return Float(frame.size.height)
    }
    
    //MARK: - addShadowToView
    func addShadowToView(vw:UIView) {
        
        vw.layer.masksToBounds = false
        vw.layer.shadowOffset = CGSize(width: 0, height:2.0)
        vw.layer.shadowRadius = 2.0
        vw.layer.shadowOpacity = 0.1
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
