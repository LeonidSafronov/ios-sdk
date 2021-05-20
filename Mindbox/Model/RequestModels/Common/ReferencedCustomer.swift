//
//  ReferencedCustomer.swift
//  Mindbox
//
//  Created by Mikhail Plotnikov on 06.05.2021.
//  Copyright © 2021 Mikhail Barilov. All rights reserved.
//

import Foundation

public class ReferencedCustomer: Codable {
    public var email, mobilePhone: String?
    public var ids: IDS?
    public var discountCard: DiscountCard?

    public init(email: String?, mobilePhone: String?, ids: IDS?, discountCard: DiscountCard?) {
        self.email = email
        self.mobilePhone = mobilePhone
        self.ids = ids
        self.discountCard = discountCard
    }

    // MARK: - ReferencedCustomerids

    public class IDS: Codable {
        public var mindboxId: Int?
        public var myAwesomeId, websiteid: String?

        public init(mindboxId: Int?, myAwesomeId: String?, websiteid: String?) {
            self.mindboxId = mindboxId
            self.myAwesomeId = myAwesomeId
            self.websiteid = websiteid
        }
    }
}