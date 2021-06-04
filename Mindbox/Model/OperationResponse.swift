//
//  OperationResponse.swift
//  Mindbox
//
//  Created by Ihor Kandaurov on 28.05.2021.
//  Copyright © 2021 Mikhail Barilov. All rights reserved.
//

import Foundation

open class OperationResponse: OperationResponseType {
    public var status: Status
    public let customer: CustomerResponse?
    public let productList: ProductListResponse?
    public let productListIte
    public let recommendation: [RecommendationResponse]?
    public let customerSegmentations: [CustomerSegmentationResponse]?
    public let setProductCountInList: ProductListResponse?
    public let promoCode: PromoCodeResponse?

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        status = try container.decode(Status.self, forKey: .status)
        customer = try container.decodeIfPresent(CustomerResponse.self, forKey: .customer)
        let
        productList =
        recommendation = try container.decodeIfPresent([RecommendationResponse].self, forKey: .recommendation)
        customerSegmentations = try container.decodeIfPresent([CustomerSegmentationResponse].self, forKey: .customerSegmentations)
        setProductCountInList = try container.decodeIfPresent(ProductListResponse.self, forKey: .setProductCountInList)
        promoCode = try container.decodeIfPresent(PromoCodeResponse.self, forKey: .promoCode)
    }

    enum Keys: String, CodingKey {
        case status
        case customer
        case productList
        case recommendation
        case customerSegmentations
        case setProductCountInList
        case promoCode
    }
}
