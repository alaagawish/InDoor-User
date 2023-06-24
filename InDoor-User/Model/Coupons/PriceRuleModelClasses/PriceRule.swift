//
//  RootClass.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on June 17, 2023
//
import Foundation

struct PriceRule: Codable {

	var allocationMethod: String?
	var createdAt: String?
	var updatedAt: String?
	var customerSelection: String?
	var endsAt: String?
	var entitledCollectionIds: [Int]?
//	var entitledCountryIds: EntitledCountryIds?
	var entitledProductIds: [Int]?
	var entitledVariantIds: [Int]?
	var id: Int?
	var oncePerCustomer: Bool?
	var prerequisiteCustomerIds: [Int]?
	var prerequisiteQuantityRange: PrerequisiteQuantityRange?
	var customerSegmentPrerequisiteIds: [Int]?
	var prerequisiteShippingPriceRange: PrerequisiteShippingPriceRange?
	var prerequisiteSubtotalRange: PrerequisiteSubtotalRange?
	var prerequisiteToEntitlementPurchase: PrerequisiteToEntitlementPurchase?
	var startsAt: String?
	var targetSelection: String?
	var targetType: String?
	var title: String?
	var usageLimit: Int?
	var prerequisiteProductIds: [Int]?
	var prerequisiteVariantIds: [Int]?
	var prerequisiteCollectionIds: [Int]?
	var value: String?
	var valueType: String?
	var prerequisiteToEntitlementQuantityRatio: PrerequisiteToEntitlementQuantityRatio?
	var allocationLimit: Int?

	private enum CodingKeys: String, CodingKey {
		case allocationMethod = "allocation_method"
		case createdAt = "created_at"
		case updatedAt = "updated_at"
		case customerSelection = "customer_selection"
		case endsAt = "ends_at"
		case entitledCollectionIds = "entitled_collection_ids"
	//	case entitledCountryIds = "entitled_country_ids"
		case entitledProductIds = "entitled_product_ids"
		case entitledVariantIds = "entitled_variant_ids"
		case id = "id"
		case oncePerCustomer = "once_per_customer"
		case prerequisiteCustomerIds = "prerequisite_customer_ids"
		case prerequisiteQuantityRange = "prerequisite_quantity_range"
		case customerSegmentPrerequisiteIds = "customer_segment_prerequisite_ids"
		case prerequisiteShippingPriceRange = "prerequisite_shipping_price_range"
		case prerequisiteSubtotalRange = "prerequisite_subtotal_range"
		case prerequisiteToEntitlementPurchase = "prerequisite_to_entitlement_purchase"
		case startsAt = "starts_at"
		case targetSelection = "target_selection"
		case targetType = "target_type"
		case title = "title"
		case usageLimit = "usage_limit"
		case prerequisiteProductIds = "prerequisite_product_ids"
		case prerequisiteVariantIds = "prerequisite_variant_ids"
		case prerequisiteCollectionIds = "prerequisite_collection_ids"
		case value = "value"
		case valueType = "value_type"
		case prerequisiteToEntitlementQuantityRatio = "prerequisite_to_entitlement_quantity_ratio"
		case allocationLimit = "allocation_limit"
	}
}
