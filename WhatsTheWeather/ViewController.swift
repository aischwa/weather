//
//  ViewController.swift
//  WhatsTheWeather
//
//  Created by Alex Schwartz on 2/15/16.
//  Copyright © 2016 Alex Schwartz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var cityTextField: UITextField!
    @IBAction func findWeather(sender: AnyObject) {
        let url = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text! + "/forecasts/latest")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){
            (data,response,error) -> Void in
            if error == nil{
                let urlcontent = NSString(data: data!, encoding: NSUTF8StringEncoding)
                //print(urlcontent)
                
                let websiteArray = urlcontent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                dispatch_async(dispatch_get_main_queue()){
                    if websiteArray!.count > 0 {
                        let weatherArray = websiteArray![1].componentsSeparatedByString("</span>")
                        if weatherArray.count > 0 {
                            let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                            print(weatherSummary)
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in self.resultLabel.text = weatherSummary
                            })
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    @IBOutlet weak var resultLabel: UITextView!
}
