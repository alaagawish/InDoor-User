//
//  FavoritesViewModelTests.swift
//  InDoor-UserTests
//
//  Created by Alaa on 23/06/2023.
//

import XCTest
@testable import InDoor_User
final class FavoritesViewModelTests: XCTestCase {

    var network: NetworkProtocol!
    var localDatabase: DatabaseService!
    var favouritesViewModel: FavoritesViewModel!
    
    override func setUpWithError() throws {
        network = NetworkMock(isSuccess: true)
        localDatabase = LocalSource()
        favouritesViewModel = FavoritesViewModel(service: localDatabase, network: network) 
    }

    override func tearDownWithError() throws {
    }

   

}
