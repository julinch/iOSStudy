//
//  FacebookLoginViewController.swift
//  GalleryGuide
//
//  Created by Juliya on 30.06.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import UIKit

class FacebookLoginViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var loginViaFacebookButton: UIButton!
    @IBOutlet weak var loginLaterButton: UIButton!
    
    var timer = Timer()
    private var currentIndex:Int = 0
    private let maxLimit = 2
    private let minLimit = 0
    
    @IBAction func loginLaterButtonPressed(_ sender: Any) {
        timer.invalidate()
    }
    
    @IBAction func pageControlValueChanged(_ sender: UIPageControl) {
        if sender.currentPage > currentIndex {
            currentIndex += 1
            moveToNextPage()
        }
        else
        {
            currentIndex -= 1
            moveToPrevPage()
        }
        
        restartTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        let scrollViewWidth: CGFloat = self.scrollView.frame.width
        let scrollViewHeight: CGFloat = self.scrollView.frame.height
        self.loginViaFacebookButton.layer.cornerRadius = 4.0
        
        for i in 0..<3
        {
            let image = UIImageView(frame: CGRect(x:scrollViewWidth * CGFloat(i), y:0,width:scrollViewWidth, height:scrollViewHeight))
            image.image = UIImage(named: "Picture\(i+1)")
            
            self.scrollView.addSubview(image)
        }
        
        textView.text = "Gallery Guru is your personalized guide to art galleries"
        scrollView.contentSize = CGSize(width:self.scrollView.frame.width * 3, height:(UIImage(named: "Picture1")?.size.height)!)
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
        startTimer()
        
        
        
    }

    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollingFinished()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollingFinished()
        restartTimer()
    }

    func moveToNextPage (){
        
        let pageWidth:CGFloat = self.scrollView.frame.width
        let maxWidth:CGFloat = pageWidth * 3
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
        }

        self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollView.frame.height), animated: true)
               
        }

    func moveToPrevPage (){
        
        let pageWidth:CGFloat = self.scrollView.frame.width
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        let slideToX = contentOffset - pageWidth
        
        self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollView.frame.height), animated: true)
        
    }
    
    func scrollingFinished () {
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth)/pageWidth)+1
        
        self.pageControl.currentPage = Int(currentPage);
        
        if Int(currentPage) == 0{
            textView.text = "Gallery Guru is your personalized guide to art galleries"
        }else if Int(currentPage) == 1{
            textView.text = "Explore galleries and exhibitions around you"
        }else if Int(currentPage) == 2{
            textView.text = "Stay updated and follow galleries you like"
        }

    }
    
    func restartTimer () {
        timer.invalidate()
        startTimer()
    }
    func startTimer () {
        timer =  Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
    }
    
    
}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


