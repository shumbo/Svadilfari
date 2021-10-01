//
//  SafariWebExtensionHandler.swift
//  SvadilfariExtension
//
//  Created by Shun Kashiwa on 2021/07/30.
//

import SafariServices
import CoreData
import os.log

class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {
    lazy var moc: NSManagedObjectContext = {
        let context = PersistenceController.shared.container.viewContext
        context.name = "view_context"
        context.transactionAuthor = "safari_extension"

        let persistentHistoryObserver = PersistentHistoryObserver(
            target: .safariExtension,
            persistentContainer: PersistenceController.shared.container, userDefaults: UserDefaults.shared)
        persistentHistoryObserver.startObserving()
        return context
    }()

    lazy var els: ExclusionListService = {
        return ExclusionListService(moc: self.moc)
    }()

    // swiftlint:disable:next function_body_length cyclomatic_complexity
    func beginRequest(with context: NSExtensionContext) {
        // swiftlint:disable all
        let item = context.inputItems[0] as! NSExtensionItem
        let message = item.userInfo?[SFExtensionMessageKey]
        
        // TODO
        
        // swiftlint:disable:next all
        os_log(.default, "Received message from browser.runtime.sendNativeMessage: %@", message as! CVarArg)

        // helper that returns json
        func respond(json: String) {
            let response = NSExtensionItem()
            response.userInfo = [ SFExtensionMessageKey: json ]
            context.completeRequest(returningItems: [response], completionHandler: nil)
        }
        func respondError(msg: String) {
            respond(json: "{\"error\": \"\(msg)\"}")
        }
        func respond<T: Encodable>(_ response: T) {
            do {
                let data = try newJSONEncoder().encode(response)
                respond(json: String(data: data, encoding: .utf8) ?? "{}")
            } catch {
                respondError(msg: "Failed to encode data")
            }
        }
        func respond() {
            respond(json: "{}")
        }

        guard let str = message as? String, let req = try? MessageRequest(str) else {
            respondError(msg: "Failed to decode the message")
            return
        }

        if req.getGestures != nil {
            var gestures: [Gesture] = []
            let request = GestureEntity.fetchRequest()
            do {
                let result = try self.moc.fetch(request)
                gestures = result.compactMap { $0.gesture }
            } catch {
                respondError(msg: "Failed to fetch gestures")
                return
            }
            let response = GetGestureResponse(error: nil, gestures: gestures)
            respond(response)
            return
        }

        if let getExclusionEntryRequest = req.getExclusionEntry {
            var entry: ExclusionEntryEntity?
            do {
                entry = try self.els.fetchRelevantEntry(
                    domain: getExclusionEntryRequest.domain,
                    path: getExclusionEntryRequest.path
                )
            } catch {
                respondError(msg: "Failed to get an exclusion entry")
                return
            }

            var response: GetExclusionEntryResponse
            if let entry = entry {
                guard let domain = entry.domain, let uuid = entry.id?.uuidString else {
                    respondError(msg: "Found an invalid entry")
                    return
                }
                response = GetExclusionEntryResponse(
                    exclusionEntry: GetExclusionEntryResponseExclusionEntry(
                        domain: domain,
                        id: uuid,
                        path: entry.path
                    )
                )
            } else {
                response = GetExclusionEntryResponse(exclusionEntry: nil)
            }
            respond(response)
            return
        }

        if let addExclusionEntryRequest = req.addExclusionEntry {
            do {
                try self.els.add(domain: addExclusionEntryRequest.domain, path: addExclusionEntryRequest.path)
            } catch {
                respondError(msg: "Failed to add an exclusion entry")
                return
            }
            respond()
            return
        }

        if let removeExclusionEntryRequest = req.removeExclusionEntry {
            do {
                try self.els.remove(uuid: removeExclusionEntryRequest.id)
            } catch {
                respondError(msg: "Failed to remove exclusion entry")
                return
            }
            respond()
            return
        }

        respond(json: "Failed to find a request handler")
    }
}
