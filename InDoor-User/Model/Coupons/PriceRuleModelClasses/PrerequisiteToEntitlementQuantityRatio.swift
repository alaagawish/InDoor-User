//
//  PrerequisiteToEntitlementQuantityRatio.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on June 17, 2023
//
import Foundation

struct PrerequisiteToEntitlementQuantityRatio: Codable {

	var prerequisiteQuantity: Int?
	var entitledQuantity: Int?

	private enum CodingKeys: String, CodingKey {
		case prerequisiteQuantity = "prerequisite_quantity"
		case entitledQuantity = "entitled_quantity"
	}

}
