//
//  InAppMessagesEventSender.swift
//  Mindbox
//
//  Created by Akylbek Utekeshev on 05.04.2023.
//  Copyright © 2023 Mindbox. All rights reserved.
//

import Foundation
import MindboxLogger

class InappMessageEventSender {
    private let inAppMessagesManager: InAppCoreManagerProtocol?
    private let sessionStorage: SessionTemporaryStorage?

    init(inAppMessagesManager: InAppCoreManagerProtocol?,
         sessionStorage: SessionTemporaryStorage?) {
        self.inAppMessagesManager = inAppMessagesManager
        self.sessionStorage = sessionStorage
    }

    func sendEventIfEnabled(_ operatingSystemName: String, jsonString: String?) {
        guard let isPresenting = sessionStorage?.isPresentingInAppMessage, !isPresenting else {
            Logger.common(message: "In-app was already shown in this session", category: .inAppMessages)
            return
        }

        let lowercasedName = operatingSystemName.lowercased()
        let jsonString = jsonString ?? ""

        if shouldSendEventForOperation(lowercasedName) {
            let model = decodeInAppOperationJSONModel(from: jsonString)
            inAppMessagesManager?.sendEvent(.applicationEvent(.init(name: lowercasedName, model: model)))
        }
    }

    private func shouldSendEventForOperation(_ operationName: String) -> Bool {
        guard let sessionStorage = sessionStorage else {
            return false
        }

        return sessionStorage.customOperations.contains(operationName)
            || sessionStorage.operationsFromSettings.contains(operationName)
    }

    private func decodeInAppOperationJSONModel(from jsonString: String) -> InappOperationJSONModel? {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return nil
        }

        do {
            let model = try JSONDecoder().decode(InappOperationJSONModel.self, from: jsonData)
            return model
        } catch {
            Logger.common(message: "Failed to decode InappOperationJSONModel: \(error.localizedDescription)", level: .error, category: .inAppMessages)
            return nil
        }
    }
}
