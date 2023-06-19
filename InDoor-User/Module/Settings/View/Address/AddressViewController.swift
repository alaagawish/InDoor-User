//
//  AddressViewController.swift
//  InDoor-User
//
//  Created by Mac on 04/06/2023.
//

import UIKit

class AddressViewController: UIViewController {
    
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var addressesTable: UITableView!
    var settingsViewModel: SettingsViewModel!
    var addressesList: [Address] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsViewModel = SettingsViewModel(netWorkingDataSource: Network())
        checkAddressListCount()
        setupUI()
        callingData()
        setNibFile()
        
        settingsViewModel.bindDeleteAddressToViewController = { [weak self] in
            self?.addressesTable.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkAddressListCount()
        setupUI()
        callingData()
    }
    
    func setNibFile(){
        let nibFile = UINib(nibName: Constants.addressCellNibFile, bundle: nil)
        addressesTable.register(nibFile, forCellReuseIdentifier: Constants.addressCell)
    }
    
    func setupUI(){
        continueButton.layer.cornerRadius = 12
    }
    
    func callingData(){
        settingsViewModel.bindAddressToViewController = {[weak self] in
            self?.addressesList = self?.settingsViewModel.result ?? []
            self?.checkAddressListCount()
            self?.addressesTable.reloadData()
        }
        settingsViewModel.getAddresses()
    }
    
    func checkAddressListCount(){
        if addressesList.count == 0{
            addressesTable.isHidden = true
        }else{
            addressesTable.isHidden = false
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func addAddressButton(_ sender: UIButton) {
        let addAddress = self.storyboard?.instantiateViewController(withIdentifier: Constants.addAddressIdentifier) as! AddAddressViewController
        addAddress.modalPresentationStyle = .fullScreen
        present(addAddress, animated: true)
    }
    
    @IBAction func continueToPaymentButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Payment", bundle: nil)
        let pay = storyboard.instantiateViewController(withIdentifier: "payment") as! PaymentViewController
        pay.modalPresentationStyle = .fullScreen
        present(pay, animated: true)
    }
}

extension AddressViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.addressCell) as! AddressTableViewCell
        
        cell.setValues(name: addressesList[indexPath.row].name ?? "", city: addressesList[indexPath.row].city ?? "", address: addressesList[indexPath.row].address1 ?? "")
        
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    //        true
    //    }
    //
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if(editingStyle == .delete){
    //
    //            if addressesList[indexPath.row].default ?? false {
    //                let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.defaultAddressMsg, positiveButtonTitle: Constants.ok)
    //                self.present(alert, animated: true)
    //            }else{
    //                let alert = Alert().showAlertWithNegativeAndPositiveButtons(title: Constants.removeAddressTitle, msg: Constants.removeAddressMsg, negativeButtonTitle: Constants.cancel, positiveButtonTitle: Constants.ok, positiveHandler: { [weak self] action in
    //                    self?.settingsViewModel.deleteAddress(path: "\(Constants.addressPath)/\(self?.addressesList[indexPath.row].id ?? 0)")
    //                    self?.addressesList.remove(at: indexPath.row)
    //                    self?.addressesTable.reloadData()
    //                })
    //                self.present(alert, animated: true)
    //            }
    //        }
    //    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let addAddress = self.storyboard?.instantiateViewController(withIdentifier: Constants.addAddressIdentifier) as! AddAddressViewController
    //
    //        addAddress.updateAddress = addressesList[indexPath.row]
    //        addAddress.toUpdateAddress = true
    //
    //        addAddress.modalPresentationStyle = .fullScreen
    //        present(addAddress, animated: true)
    //    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: Constants.delete) { action, view, handler in
            
            if self.addressesList[indexPath.row].default ?? false {
                let alert = Alert().showAlertWithPositiveButtons(title: Constants.warning, msg: Constants.defaultAddressMsg, positiveButtonTitle: Constants.ok)
                self.present(alert, animated: true)
            }else{
                let alert = Alert().showAlertWithNegativeAndPositiveButtons(title: Constants.removeAddressTitle, msg: Constants.removeAddressMsg, negativeButtonTitle: Constants.cancel, positiveButtonTitle: Constants.ok, positiveHandler: { [weak self] action in
                    self?.settingsViewModel.deleteAddress(path: "\(Constants.addressPath)/\(self?.addressesList[indexPath.row].id ?? 0)")
                    self?.addressesList.remove(at: indexPath.row)
                    self?.addressesTable.reloadData()
                })
                self.present(alert, animated: true)
            }
            
            handler(true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: Constants.edit) { action, view, handler in
            let addAddress = self.storyboard?.instantiateViewController(withIdentifier: Constants.addAddressIdentifier) as! AddAddressViewController
            
            addAddress.updateAddress = self.addressesList[indexPath.row]
            addAddress.toUpdateAddress = true
            
            addAddress.modalPresentationStyle = .fullScreen
            self.present(addAddress, animated: true)
            
            handler(true)
        }
        
        editAction.backgroundColor = UIColor.black
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}
