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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsViewModel = SettingsViewModel(netWorkingDataSource: Network())
        userDefaults = UserDefaults.standard
        callingData()
        
        print("++++++++++\(userDefaults.string(forKey: "newCurrency"))")
    }
    
    func callingData(){
        settingsViewModel.bindCurrencyToViewController = {[weak self] in
            DispatchQueue.main.async {
                self?.currencies = self?.settingsViewModel.result ?? []
                self?.currencyTableView.reloadData()
            }
        }
        settingsViewModel.getCurrencies()
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userDefaults.set(currencies[indexPath.row].currency, forKey: "newCurrency")
        
        print("-------------\(userDefaults.string(forKey: "newCurrency"))")
    }
}

