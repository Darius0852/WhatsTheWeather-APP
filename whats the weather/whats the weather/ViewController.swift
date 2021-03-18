//
//  ViewController.swift
//  whats the weather
//
//  Created by darius ghomashchian on 05/07/2019.
//  Copyright © 2019 darius ghomashchian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityEntered: UITextField!
    
    @IBOutlet weak var displayWeather: UILabel!
    
    
    @IBAction func checkButton(_ sender: Any) {
        
        
        if let url = URL(string: "https://www.weather-forecast.com/locations/" + cityEntered.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest") {
        
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            var message = ""
            
            if error != nil {
                
                print(error)
                print("hello")
                
            } else {
                
                if let unwrappedData = data {
                    
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    
                    var stringSeperator = "<p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
                    
                    if let contentArray = dataString?.components(separatedBy: stringSeperator) {
                        
                        if contentArray.count > 1 {
                            
                            stringSeperator = "</span>"
                            
                            let newContentArray = contentArray[1].components(separatedBy: stringSeperator)
                            
                            if newContentArray.count > 1 {
                                
                                message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                
                                print(message)
                                
                            }
                            
                            
                            
                        }
                        
                    }
                    
                    
                    
                }
                
            }
            
            
            if message == "" {
                
                message = "The weather there couldn't be found. Please try again later."
                
            }
            
            DispatchQueue.main.sync(execute: {
                
                self.displayWeather.text = message
                
            })
            
            
        }
        
        task.resume()
        
        } else {
            
            displayWeather.text = "The weather there couldn't be found. Please try again later."
            
        }
        
    }
        
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        



}

}

