//
//  Orders.swift
//  InDoor-User
//
//  Created by Alaa on 10/06/2023.
//

import Foundation
struct Orders: Codable {
    
    let id: Int
    let adminGraphqlApiId: String
    let appId: Int
    let buyerAcceptsMarketing: Bool
    let confirmed: Bool
    let contactEmail: String
    let createdAt: String
    let currency: String
    let currentSubtotalPrice: String
    let currentSubtotalPriceSet: TotalPriceSet
    let currentTotalDiscounts: String
    let currentTotalDiscountsSet: TotalPriceSet
    let currentTotalPrice: String
    let currentTotalPriceSet: TotalPriceSet
    let currentTotalTax: String
    let currentTotalTaxSet: TotalPriceSet
    //   let discountCodes: [Any]
    let email: String
    let estimatedTaxes: Bool
    let financialStatus: String
    let name: String
    let number: Int
    let orderNumber: Int
    let orderStatusUrl: String
    // let phone: String
    let presentmentCurrency: String
    let processedAt: String
    let sourceName: String
    let subtotalPrice: String
    let subtotalPriceSet: TotalPriceSet
    let tags: String
    let taxesIncluded: Bool
    let test: Bool
    let token: String
    let totalDiscounts: String
    let totalDiscountsSet: TotalPriceSet
    let totalLineItemsPrice: String
    let totalLineItemsPriceSet: TotalPriceSet
    let totalOutstanding: String
    let totalPrice: String
    let totalPriceSet: TotalPriceSet
    let totalShippingPriceSet: TotalPriceSet
    let totalTax: String
    let totalTaxSet: TotalPriceSet
    let totalTipReceived: String
    let totalWeight: Int
    let updatedAt: String
    // let userId: Int
    let billingAddress: BillingAddress
    let customer: Customer
    let lineItems: [LineItems]
    let shippingAddress: BillingAddress
    
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case adminGraphqlApiId = "admin_graphql_api_id"
        case appId = "app_id"
        case buyerAcceptsMarketing = "buyer_accepts_marketing"
        case confirmed = "confirmed"
        case contactEmail = "contact_email"
        case createdAt = "created_at"
        case currency = "currency"
        case currentSubtotalPrice = "current_subtotal_price"
        case currentSubtotalPriceSet = "current_subtotal_price_set"
        case currentTotalDiscounts = "current_total_discounts"
        case currentTotalDiscountsSet = "current_total_discounts_set"
        case currentTotalPrice = "current_total_price"
        case currentTotalPriceSet = "current_total_price_set"
        case currentTotalTax = "current_total_tax"
        case currentTotalTaxSet = "current_total_tax_set"
        //    case discountCodes = "discount_codes"
        case email = "email"
        case estimatedTaxes = "estimated_taxes"
        case financialStatus = "financial_status"
        case name = "name"
        case number = "number"
        case orderNumber = "order_number"
        case orderStatusUrl = "order_status_url"
        //  case phone = "phone"
        case presentmentCurrency = "presentment_currency"
        case processedAt = "processed_at"
        case sourceName = "source_name"
        case subtotalPrice = "subtotal_price"
        case subtotalPriceSet = "subtotal_price_set"
        case tags = "tags"
        case taxesIncluded = "taxes_included"
        case test = "test"
        case token = "token"
        case totalDiscounts = "total_discounts"
        case totalDiscountsSet = "total_discounts_set"
        case totalLineItemsPrice = "total_line_items_price"
        case totalLineItemsPriceSet = "total_line_items_price_set"
        case totalOutstanding = "total_outstanding"
        case totalPrice = "total_price"
        case totalPriceSet = "total_price_set"
        case totalShippingPriceSet = "total_shipping_price_set"
        case totalTax = "total_tax"
        case totalTaxSet = "total_tax_set"
        case totalTipReceived = "total_tip_received"
        case totalWeight = "total_weight"
        case updatedAt = "updated_at"
        //   case userId = "user_id"
        case billingAddress = "billing_address"
        case customer = "customer"
        case lineItems = "line_items"
        case shippingAddress = "shipping_address"
        
    }
    
}
