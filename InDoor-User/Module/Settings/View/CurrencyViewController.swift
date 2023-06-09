//
//  CurrencyViewController.swift
//  InDoor-User
//
//  Created by Mac on 04/06/2023.
//

import UIKit

class CurrencyViewController: UIViewController {
    @IBOutlet weak var currencyTableView: UITableView!
    
    var settingsViewModel: SettingsViewModel!
    var userDefaults: UserDefaults!
    var currencies:[Currency] = []
    let currencySymbol = ["د.إ", "AU$", "CA$", "CHF", "Kč", "kr", "€", "GBP£", "HK$", "₪", "¥", "₩", "RM", "NZ$", "zł", "kr", "SG$", "$", "E£"]
    var rates: Rates!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsViewModel = SettingsViewModel(netWorkingDataSource: Network())
        userDefaults = UserDefaults.standard
        callingData()
        callingEquivalentCurrency()
        
        print("++++++++++\(userDefaults.string(forKey: "newCurrency"))")
        print("++++++++++\(userDefaults.string(forKey: "rates"))")
    }
    
    func callingData(){
        settingsViewModel.bindCurrencyToViewController = {[weak self] in
            DispatchQueue.main.async {
                self?.currencies = self?.settingsViewModel.result ?? []
                self?.currencies.append(Currency(currency: "EGP", rateUpdatedAt: "2023-06-08T20:14:30-04:00", enabled: true))
                self?.currencyTableView.reloadData()
            }
        }
        settingsViewModel.getCurrencies()
    }
    
    func callingEquivalentCurrency(){
        settingsViewModel.bindRatesToViewController = {[weak self] in
            self?.rates = self?.settingsViewModel.rates
        }
        settingsViewModel.getEquivalentCurrencies()
    }

    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension CurrencyViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyTableViewCell
        
        cell.currencyLabel.text = currencies[indexPath.row].currency
        cell.currencySymbolLabel.text = currencySymbol[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userDefaults.set(currencies[indexPath.row].currency, forKey: "newCurrency")
        userDefaults.set(mappingCurrency(currency: currencies[indexPath.row].currency ?? "noRates"), forKey: "rates")
        
        print("++++++++++rates \(mappingCurrency(currency: currencies[indexPath.row].currency ?? "noRates"))")
        print("-------------\(userDefaults.string(forKey: "newCurrency"))")
        print("-------------\(userDefaults.string(forKey: "rates"))")
    }
    
    func mappingCurrency(currency: String) -> Double{
        if currency == "AED"{
            return rates.AED ?? 1.0
        }
        else if currency == "AUD"{
            return rates.AUD ?? 1.0
        }
        else if currency == "CAD"{
            return rates.CAD ?? 1.0
        }
        else if currency == "CHF"{
            return rates.CHF ?? 1.0
        }
        else if currency == "CZK"{
            return rates.CZK ?? 1.0
        }
        else if currency == "DKK"{
            return rates.DKK ?? 1.0
        }
        else if currency == "EGP"{
            return rates.EGP ?? 1.0
        }
        else if currency == "EUR"{
            return rates.EUR ?? 1.0
        }
        else if currency == "GBP"{
            return rates.GBP ?? 1.0
        }
        else if currency == "HKD"{
            return rates.HKD ?? 1.0
        }
        else if currency == "ILS"{
            return rates.ILS ?? 1.0
        }
        else if currency == "JPY"{
            return rates.JPY ?? 1.0
        }
        else if currency == "KRW"{
            return rates.KRW ?? 1.0
        }
        else if currency == "MYR"{
            return rates.MYR ?? 1.0
        }
        else if currency == "NZD"{
            return rates.NZD ?? 1.0
        }
        else if currency == "PLN"{
            return rates.PLN ?? 1.0
        }
        else if currency == "SEK"{
            return rates.SEK ?? 1.0
        }
        else if currency == "SGD"{
            return rates.SGD ?? 1.0
        }
        else{
            return rates.USD ?? 1.0
        }
    }
}
