//
//  MockAPIFileLoader.swift
//  InDoor-UserTests
//
//  Created by Alaa on 16/06/2023.
//

import Foundation
@testable import InDoor_User

class MockAPIFileLoader {
    
    func loadApiFiles() -> Response? {
        let bundle = Bundle(for: type(of: self))
        let fileUrl =  bundle.url(forResource: "MockResponse", withExtension: "json")
        do {
            let data = try Data(contentsOf: fileUrl!)
            let response = try JSONDecoder().decode(Response.self, from: data)
            return response
        } catch {
            return nil
        }
    }
    
    func loadApiCurrency() -> Response? {
        let bundle = Bundle(for: type(of: self))
        let fileUrl =  bundle.url(forResource: "CurrencyMock", withExtension: "json")
        do {
            let data = try Data(contentsOf: fileUrl!)
            let response = try JSONDecoder().decode(Response.self, from: data)
            return response
        } catch {
            return nil
        }
    }
    
    
    private func generateModel(for path: String) -> Response? {
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
              let mockyJSON = try? JSONDecoder().decode(Response.self, from: data)
        else { return nil }
        return mockyJSON
    }
    
}

