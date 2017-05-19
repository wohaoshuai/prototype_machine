//
//  ViewController.swift
//  prototype_game
//
//  Created by Kelong Wu on 5/17/17.
//  Copyright © 2017 alien_robot_cat. All rights reserved.
//
//
//  ViewController.swift
//  prototype_dream
//
//  Created by Kelong Wu on 5/18/17.
//  Copyright © 2017 AlienRobotCat. All rights reserved.
//

import UIKit

extension UIView{
    
    func createFrame(tag: Int){
        let view = UIView()
        view.frame = CGRect(x: 50, y: 50, width: 308.424689836401, height: 548.584714989012)
        view.backgroundColor = UIColor(red:0.99, green:0.99, blue:0.99, alpha:1.0)
        view.tag = tag
        addSubview(view)
    }
    
    func addShadow(){
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 4;
        self.layer.shadowOpacity = 0.65;
    }
    
    func findSubviewWithTag(tag: Int)->UIView?{
        let r = findSubview(v: self, t: tag)
        return r
    }
    
    private func findSubview(v: UIView, t: Int)->UIView?{
        if v.tag == t {
            return v
        }
        
        for subview in v.subviews {
            let r = findSubview(v: subview, t: t)
            if r != nil{
                return r
            }
        }
        
        return nil
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.createFrame(tag: 1)
        print(view.frame.size)
        
        view.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.96, alpha:1.0)
        
        let r = UIPanGestureRecognizer()
        r.addTarget(self, action: #selector(self.mover(_:)))
        view.findSubviewWithTag(tag: 1)?.addGestureRecognizer(r)
        
        let v = view.findSubviewWithTag(tag: 1)
        v?.addShadow()
        
        
    }
    
    var h0 = CGFloat(0)
    var w0 = CGFloat(0)
    func scaler(_ sender: UIPanGestureRecognizer){
        if let v = view.findSubviewWithTag(tag: 1){
            if sender.state == UIGestureRecognizerState.began {
                print("begin")
                h0 = v.frame.size.height
                w0 = v.frame.size.width
            }
        
            print(sender.translation(in: self.view))
            let move = sender.translation(in: self.view).y
            let k = CGFloat(1)
            let ratio = (move * k * 0.002)
            print(ratio)
            
            var r = CGFloat(1)
            if ratio > 0 {
                r = 1 / (1 + ratio)
            } else {
                r = 1 * (1 - ratio)
            }
            
            print(r)

            
            let h = h0 * r
            let w = w0 * r
            v.frame.size = CGSize(width: w, height: h)
            print("h", "w")
            print(h, w)
        }
    }
    
    
    func mover(_ sender: UIPanGestureRecognizer){
        if let v = view.findSubviewWithTag(tag: 1){
            v.center.x += sender.translation(in: self.view).x
            v.center.y += sender.translation(in: self.view).y
            
            sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

