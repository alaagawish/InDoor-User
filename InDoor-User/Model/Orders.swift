//
//  Orders.swift
//  InDoor-User
//
//  Created by Alaa on 10/06/2023.
//

import Foundation

struct Orders: Codable {
    
    let id: Int?
    let contactEmail: String?
    let createdAt: String?
    let currency: String?
    let currentSubtotalPrice: String?
    let currentSubtotalPriceSet: TotalPriceSet?
    let currentTotalDiscounts: String?
    let currentTotalDiscountsSet: TotalPriceSet?
    let currentTotalPrice: String?
    let currentTotalPriceSet: TotalPriceSet?
    let currentTotalTax: String?
    let currentTotalTaxSet: TotalPriceSet?
    let email: String?
    let estimatedTaxes: Bool?
    let financialStatus: String?
    let name: String?
    let number: Int?
    let orderNumber: Int?
    let orderStatusUrl: String?
    let presentmentCurrency: String?
    let processedAt: String?
    let sourceName: String?
    let subtotalPrice: String?
    let subtotalPriceSet: TotalPriceSet?
    let tags: String?
    let taxesIncluded: Bool?
    let test: Bool?
    let token: String?
    let totalDiscounts: String?
    let totalDiscountsSet: TotalPriceSet?
    let totalLineItemsPrice: String?
    let totalLineItemsPriceSet: TotalPriceSet?
    let totalOutstanding: String?
    let totalPrice: String?
    let totalTax: String?
    let totalTaxSet: TotalPriceSet?
    let totalTipReceived: String?
    let totalWeight: Int?
    let updatedAt: String?
    let customer: Customer?
    let lineItems: [LineItems]?
    let shippingAddress: BillingAddress?
    
    init(currency: String, lineItems: [LineItems], number: Int, customer: Customer, totalPrice: String) {
        self.currency = currency
        self.lineItems = lineItems
        self.totalPrice = totalPrice
        self.number = number
        self.id = nil
        self.customer = customer
        self.shippingAddress = nil
        self.updatedAt = nil
        self.totalWeight = nil
        self.totalTax = nil
        self.totalTaxSet = nil
        self.totalTipReceived = nil
        self.presentmentCurrency = nil
        self.processedAt = nil
        self.sourceName = nil
        self.subtotalPrice = nil
        self.subtotalPriceSet = nil
        self.tags = nil
        self.taxesIncluded = nil
        self.test = nil
        self.token = nil
        self.totalDiscounts = nil
        self.totalDiscountsSet = nil
        self.totalLineItemsPrice = nil
        self.totalLineItemsPriceSet = nil
        self.totalOutstanding = nil
        self.email = nil
        self.estimatedTaxes = nil
        self.financialStatus = nil
        self.name = nil
        self.orderNumber = nil
        self.orderStatusUrl = nil
        self.contactEmail = nil
        self.createdAt = nil
        self.currentSubtotalPrice = nil
        self.currentSubtotalPriceSet = nil
        self.currentTotalDiscounts = nil
        self.currentTotalDiscountsSet = nil
        self.currentTotalPrice = nil
        self.currentTotalPriceSet = nil
        self.currentTotalTax = nil
        self.currentTotalTaxSet = nil
        
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
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
        case email = "email"
        case estimatedTaxes = "estimated_taxes"
        case financialStatus = "financial_status"
        case name = "name"
        case number = "number"
        case orderNumber = "order_number"
        case orderStatusUrl = "order_status_url"
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
        case totalTax = "total_tax"
        case totalTaxSet = "total_tax_set"
        case totalTipReceived = "total_tip_received"
        case totalWeight = "total_weight"
        case updatedAt = "updated_at"
        case customer = "customer"
        case lineItems = "line_items"
        case shippingAddress = "shipping_address"
        
    }
    
}
