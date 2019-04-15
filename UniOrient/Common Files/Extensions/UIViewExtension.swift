//
//  UIViewExtension.swift
//  Feed Me
//
/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE. 0583
*/

import UIKit

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

@IBDesignable
class DesignableTextField : UITextField {
    
}
protocol YourCellDelegate : class {
    func didPressButton(_ tag: Int)
}
extension UIView {
    
    
    /* Usage Example
     * bgView.addBottomRoundedEdge(desiredCurve: 1.5)
     */
    func addBottomRoundedEdge(desiredCurve: CGFloat?) {
        let offset: CGFloat = self.frame.width / desiredCurve!
        let bounds: CGRect = self.bounds
        
        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        
        // Set the newly created shape layer as the mask for the view's layer
        self.layer.mask = maskLayer
    }
    
    // MARK: - Loader {
    
    func StartLoading() {
        
        if let _ = viewWithTag(10000) {
            //View is already Loading
        }
        else {
            
            let lockView = UIView(frame: bounds)
            lockView.backgroundColor = UIColor.clear
            lockView.tag = 10000
            
            addSubview(lockView)
            
            let container = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            container.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
            container.layer.cornerRadius = 5
            container.clipsToBounds = true
            container.center =  lockView.center
            lockView.addSubview(container)
            
            let activity = UIActivityIndicatorView.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
            activity.style = .whiteLarge
            activity.hidesWhenStopped = true
            activity.center = container.center
            
            lockView.addSubview(activity)
            lockView.bringSubviewToFront(activity)
            
            activity.startAnimating()
        }
    }
    
    func isLoading() -> Bool {
        if viewWithTag(10000) != nil {
            return true
        }
        return false
    }
    
    func StopLoading() {
        if let lockView = viewWithTag(10000) {
            UIView.animate(withDuration: 0.2, animations: {
                
            }) { finished in
                
                lockView.removeFromSuperview()
            }
        }
    }
    
    // MARK: - }
    

    
    // MARK: - }
    
    // MARK: - View Fadeout {
    
    func fadeOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = 0.0
        }
    }
    
    func fadeIn(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = 1.0
        }
    }
    
    // MARK: - }
    
    // MARK: - ViewFromXib {
    
    class func viewFromNibName(name: String) -> UIView? {
        let views = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        return views?.first as? UIView
    }
    // MARK: - }
    
    func lock() {
        if let _ = viewWithTag(110) {
            //View is already locked
        }
        else {
            let lockView = UIView(frame: bounds)
            lockView.backgroundColor = UIColor.white
            lockView.tag = 110
            lockView.alpha = 0.7
            lockView.layer.cornerRadius = 2
            
            let activity = UIActivityIndicatorView.init(style: .gray)
            activity.hidesWhenStopped = true
            lockView.addSubview(activity)
            activity.startAnimating()
            addSubview(lockView)
            
            let Loading = UILabel()
            Loading.center = CGPoint.init(x: lockView.center.x - 85, y: lockView.center.y)
            Loading.textColor = UIColor.black
            Loading.text = "Loading..."
            Loading.font = UIFont.systemFont(ofSize: 13)
            lockView.addSubview(Loading)
            
            activity.translatesAutoresizingMaskIntoConstraints = false
            Loading.translatesAutoresizingMaskIntoConstraints = false
            
            let Info1 = ["activity":activity,"Loading":Loading]
            
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-2-[activity(30)]-3-[Loading]-2-|", options: [], metrics: nil, views: Info1))
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[activity]-0-|", options: [], metrics: nil, views: Info1))
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[Loading]-0-|", options: [], metrics: nil, views: Info1))
            
            UIView.animate(withDuration: 0.2) {
                lockView.alpha = 1.0
            }
        }
    }
    
    func unlock() {
        if let lockView = viewWithTag(110) {
            UIView.animate(withDuration: 0.2, animations: {
                lockView.alpha = 0.7
            }) { finished in
                lockView.removeFromSuperview()
            }
        }
    }
    
    func ImageLoaderStart() {
        if let _ = viewWithTag(120) {
            //View is already locked
        }
        else {
            let lockView = UIView(frame: bounds)
            lockView.backgroundColor = UIColor.clear
            lockView.tag = 120
            //            lockView.alpha = 0.7
            lockView.layer.cornerRadius = 2
            
            let activity = UIActivityIndicatorView.init(style: .gray)
            activity.hidesWhenStopped = true
            lockView.addSubview(activity)
            activity.startAnimating()
            activity.color = UIColor.black
            activity.tintColor = UIColor.black
            addSubview(lockView)
            
            activity.translatesAutoresizingMaskIntoConstraints = false
            
            let Info1 = ["activity":activity]
            
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-2-[activity]-2-|", options: [], metrics: nil, views: Info1))
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[activity]-2-|", options: [], metrics: nil, views: Info1))
            
            UIView.animate(withDuration: 0.2) {
                lockView.alpha = 1.0
            }
        }
    }
    
    func ImageLoaderStop() {
        if let lockView = viewWithTag(120) {
            UIView.animate(withDuration: 0.2, animations: {
                //                lockView.alpha = 0.7
            }) { finished in
                lockView.removeFromSuperview()
            }
        }
    }
    
    
    // MARK: - IBInspectable and IBDesignable
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}


