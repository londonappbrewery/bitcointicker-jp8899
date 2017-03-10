//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    let baseURL = "https://api.bitcoinaverage.com/ticker/"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let currencySymbol = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var currencyArrayValue : Int = 0
    var finalURL = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
       
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
   
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(currencyArray[row])
        currencyArrayValue = row
        
        finalURL = baseURL + currencyArray[row]
        print(finalURL)
        getBitCoinData(url: finalURL)
        
    }
    

    
    
    
//    
//    //MARK: - Networking
//    /***************************************************************/
//    
    func getBitCoinData(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    print("Sucess! Got BitCoin Data")
                    let bitCoinJSON : JSON = JSON(response.result.value!)
                    
                    self.updateBitCoinData(json: bitCoinJSON)
                    
                } else {
                    print("Error: \(response.result.error)")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
        }
        
    }
//
//    
//    
//    
//    
//    //MARK: - JSON Parsing
//    /***************************************************************/
//    
    func updateBitCoinData(json : JSON) {
        
        if let priceResult = json["last"].double {
            bitcoinPriceLabel.text = currencySymbol[currencyArrayValue] + String(priceResult)
            
    }
        else {
            bitcoinPriceLabel.text = "Currency unavailable"
        }
    }
//





}
