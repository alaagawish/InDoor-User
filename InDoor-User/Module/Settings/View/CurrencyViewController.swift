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
    var rates: Rates!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsViewModel = SettingsViewModel(netWorkingDataSource: Network())
        userDefaults = UserDefaults.standard
        callingData()
        callingEquivalentCurrency()
    }
    
    func callingData(){
        settingsViewModel.bindCurrencyToViewController = {[weak self] in
            DispatchQueue.main.async {
                self?.currencies = self?.settingsViewModel.result ?? []
                self?.currencies.append(Currency(currency: Constants.currency.EGP.rawValue, rateUpdatedAt: Constants.date, enabled: true))
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.currencyCellIdentifier, for: indexPath) as! CurrencyTableViewCell
        
        cell.currencyLabel.text = currencies[indexPath.row].currency
        cell.currencySymbolLabel.text = Constants.currencySymbol[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userDefaults.set(currencies[indexPath.row].currency, forKey: Constants.newCurrencyKey)
        userDefaults.set(mappingCurrency(currency: currencies[indexPath.row].currency ?? Constants.defaultValueForNoRayes), forKey: Constants.ratesKey)
    }
    
    func mappingCurrency(currency: String) -> Double{
        if currency == Constants.currency.AED.rawValue {
            return rates.AED ?? 1.0
        }
        else if currency == Constants.currency.AUD.rawValue {
            return rates.AUD ?? 1.0
        }
        else if currency == Constants.currency.CAD.rawValue {
            return rates.CAD ?? 1.0
        }
        else if currency == Constants.currency.CHF.rawValue {
            return rates.CHF ?? 1.0
        }
        else if currency == Constants.currency.CZK.rawValue {
            return rates.CZK ?? 1.0
        }
        else if currency == Constants.currency.DKK.rawValue {
            return rates.DKK ?? 1.0
        }
        else if currency == Constants.currency.EGP.rawValue {
            return rates.EGP ?? 1.0
        }
        else if currency == Constants.currency.EUR.rawValue {
            return rates.EUR ?? 1.0
        }
        else if currency == Constants.currency.GBP.rawValue {
            return rates.GBP ?? 1.0
        }
        else if currency == Constants.currency.HKD.rawValue {
            return rates.HKD ?? 1.0
        }
        else if currency == Constants.currency.ILS.rawValue {
            return rates.ILS ?? 1.0
        }
        else if currency == Constants.currency.JPY.rawValue {
            return rates.JPY ?? 1.0
        }
        else if currency == Constants.currency.KRW.rawValue {
            return rates.KRW ?? 1.0
        }
        else if currency == Constants.currency.MYR.rawValue {
            return rates.MYR ?? 1.0
        }
        else if currency == Constants.currency.NZD.rawValue {
            return rates.NZD ?? 1.0
        }
        else if currency == Constants.currency.PLN.rawValue {
            return rates.PLN ?? 1.0
        }
        else if currency == Constants.currency.SEK.rawValue {
            return rates.SEK ?? 1.0
        }
        else if currency == Constants.currency.SGD.rawValue {
            return rates.SGD ?? 1.0
        }
        else{
            return rates.USD ?? 1.0
        }
    }
}

extension CurrencyViewController{
    class Constants{
        static let currencySymbol = ["د.إ", "AU$", "CA$", "CHF", "Kč", "kr", "€", "GBP£", "HK$", "₪", "¥", "₩", "RM", "NZ$", "zł", "kr", "SG$", "$", "E£"]
        static let currencyCellIdentifier = "currencyCell"
        static let newCurrencyKey = "newCurrency"
        static let ratesKey = "rates"
        static let date = "2023-06-08T20:14:30-04:00"
        static let defaultValueForNoRayes = "noRates"
        
        enum currency: String{
            case AED, AUD, CAD, CHF, CZK, DKK, EGP, EUR, GBP, HKD, ILS, JPY, KRW, MYR, NZD, PLN, SEK, SGD
        }
    }
}
