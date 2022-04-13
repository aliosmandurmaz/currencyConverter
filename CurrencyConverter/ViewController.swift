//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ali Osman DURMAZ on 31.03.2022.
//


//Sırasıyla işlemler ;
//1) Request || Session oluşturmak
//2) Response || Data oluşturmak
//3) Parsing || Json Serialization

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getRatesClicked(_ sender: Any) {
        //1.Adım
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=04fce511b2e48b6b8ae19ed0c98ba360")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else {
                //2.adım
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        
                        DispatchQueue.main.async {
                            // 3.Adım
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD : \(cad) $"
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF : \(chf) CHF"
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP : \(gbp) £"
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY : \(jpy) ¥"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD : \(usd) $"
                                }
                                if let trLira = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY : \(trLira) ₺"
                                }
                            }
                        }
                        
                    } catch  {
                        print("error")
                    }
                }
            }
            
        }
        task.resume()
    }
}

