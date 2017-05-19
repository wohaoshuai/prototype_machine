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

// Goal
// 1.the tranformed code must be readable
// 2.the code must be portable for most devices

// Format
// ??? 1 question

// Helper
// [r]
// set up recognizer
// [l]
// set up linker

// Things Black - 262B35 - UIColor(red:0.15, green:0.17, blue:0.21, alpha:1.0)
// Things While - FFFFFF
// Things Blue - 9EC6FF
// Things Green - 5DC8AA
// Things Grey - 80868D

import UIKit

extension UIImageView{
    func createDefaultImage(){
        self.frame = CGRect(x: 100, y: 100, width: 300, height: 300)
        self.center = CGPoint(x: 200, y: 200)
        if let i = image{
            print(i.scale)
            print(i.size)
            print("hello world")
        }
    }
}

extension UILabel{
    func createDefaultLabel(){
        //self.center = CGPoint(x: 200, y: 200)
        self.frame = CGRect(x: 100, y: 100, width: 300, height: 300)
    }
}

extension UIView{
    
    func createDefault(){
        self.frame = CGRect(x: 100, y: 100, width: 293, height: 117)
        self.backgroundColor = UIColor(red:0.15, green:0.17, blue:0.21, alpha:1.0)
    }
    
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
    
    func displayTag(){
        let tagView = UILabel()
        self.clipsToBounds = false
        tagView.text = String(tag)
        tagView.frame = CGRect(x: 0, y: -30, width: 100, height: 30)
        self.addSubview(tagView)
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

class Linker {
    var sensor: Int?
    var receiver: Int?
    
    func is_full() -> Bool {
        if receiver != nil && sensor != nil{
            return true
        } else {
            return false
        }
    }
    
}

class ViewController: UIViewController {
    
    // data 1
    var linker_cache : [Linker] = []
    // return tag id of a view -> ??? why not return UIView as result to std it ???
    func findTargetWithIndex(tag: Int) -> Int?{
        for l in linker_cache{
            if l.is_full() && l.sensor == tag{
                return l.receiver
            }
        }
        return nil
    }
    
    // data 2
    var view_cache : [UIView] = []
    func findWithIndex(tag: Int) -> UIView?{
        for c in view_cache{
            if c.tag == tag{
                return c
            }
        }
        return nil
    }
    
    override func viewDidLoad() {
        // default setup
        var v: UIView?
        var r: UIGestureRecognizer!
        var l: Linker!
        super.viewDidLoad()
        
        // create 0
        view.tag = 0
        view.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.96, alpha:1.0)
        
        // create 1
        view.createFrame(tag: 1)
        print(view.frame.size)
        v = view.findSubviewWithTag(tag: 1)
        v?.addShadow()
        v?.displayTag()

        // linker 1
        r = UIPanGestureRecognizer()
        r.addTarget(self, action: #selector(self.mover(_:)))
        view.findSubviewWithTag(tag: 1)?.addGestureRecognizer(r)
        
        // create 2
        createDefault(tag: 2)
        if let v = findWithIndex(tag: 2){
            view.addSubview(v)
            v.displayTag()
        }
        
        // linker 2
        r = UIPanGestureRecognizer()
        r.addTarget(self, action: #selector(self.mover(_:)))
        view.findSubviewWithTag(tag: 2)?.addGestureRecognizer(r)
        
        // linker 3
        // r
        r = UIPanGestureRecognizer()
        r.addTarget(self, action: #selector(self.scaler(_:)))
        view.findSubviewWithTag(tag: 0)?.addGestureRecognizer(r)
        // l
        l = Linker()
        l.sensor = 0
        l.receiver = 2
        linker_cache.insert(l, at: 0)

        // create 3
        v = UIImageView(image: UIImage(named: "image_1"))
        (v as! UIImageView).createDefaultImage()
        v?.tag = 3
        v?.displayTag()
        view_cache.insert(v!, at: 0)
        view.addSubview(v!)
        // r
        r = UIPanGestureRecognizer()
        r.addTarget(self, action: #selector(self.mover(_:)))
        view.findSubviewWithTag(tag: 3)!.addGestureRecognizer(r)
        
    }
    

    
    // create default view with a tag
    func createDefault(tag: Int) -> UIView {
        let m = UIView()
        m.createDefault()
        m.tag = tag
        view_cache.insert(m, at: 0)
        return m
    }
    
    var h0 = CGFloat(0)
    var w0 = CGFloat(0)

    // of whom to scale is the question
    
    // actor on view based on gesture
    func scaler(_ sender: UIPanGestureRecognizer){
        
        var tag = sender.view?.tag
        if let target = findTargetWithIndex(tag: tag!){
            print("ffffffffffff")
            tag = target
        }

        if let v = view.findSubviewWithTag(tag: tag!){
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
    
    // of whom to move is a question
    func mover(_ sender: UIPanGestureRecognizer){
        // CCC
        var tag = sender.view?.tag
        if let target = findTargetWithIndex(tag: tag!){
            tag = target
        }
        
        if let v = view.findSubviewWithTag(tag: tag!){
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

