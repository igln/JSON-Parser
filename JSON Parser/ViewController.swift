//////////////////////////////////////////////////////////////////
//  ViewController.swift                                        //
//  JSON Parser                                                 //
//                                                              //
//  Created by Farid Golchin on 8/13/17.                        //
//  Copyright © 2017 iGolchin Foundation. All rights reserved.  //
//////////////////////////////////////////////////////////////////


import UIKit

///////////////////////////////////////////////////

class ViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
    }

///////////////////////////////////////////////////


@IBOutlet weak var myLink: UITextField!
@IBOutlet weak var myJSON: UITextView!

///////////////////////////////////////////////////
    
enum JSONError: String, Error
    {
        case noData = "ERROR: no data"
        case conversionFailed = "ERROR: conversion from JSON failed"
    }

///////////////////////////////////////////////////


@IBAction func Parse(_ sender: Any)
    {
        let urlPath = self.myLink.text
        guard let endpoint = URL(string: urlPath!) else
        {
            print("Error creating endpoint")
            return
        }
        URLSession.shared.dataTask(with: endpoint) { (data, response, error) in
            do{
                guard let data = data else
                {
                    throw JSONError.noData
                }
                
                 //Saving JSON in an Object (NSDictionary)
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else
                {
                    print("2")
                    throw JSONError.conversionFailed
                }
                
                //Iterating the JSON dict
                
                NSLog("My JSON is %@", json)
                var fullDict = ""
                
                for (x, y) in json {
                    fullDict += "(\(x): \(y))\n"
                    
                }
                DispatchQueue.main.async()
                {
                self.myJSON.text = fullDict
                }
                
                //ERROR Handling
                
                } catch let error as JSONError
                {
                    print("3")
                    print(error.rawValue)
                } catch let error as NSError
                {
                    print("4")
                    print(error.debugDescription)
                }
                }.resume()
        
        
    }
    
///////////////////////////////////////////////////
    @IBAction func Clear(_ sender: Any) {
        self.myJSON.text = ""
    }

///////////////////////////////////////////////////

       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

