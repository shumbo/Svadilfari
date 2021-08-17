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

    let moc = PersistenceController.shared.container.viewContext

    // swiftlint:disable function_body_length
    func beginRequest(with context: NSExtensionContext) {
        // swiftlint:disable all
        let item = context.inputItems[0] as! NSExtensionItem
        let message = item.userInfo?[SFExtensionMessageKey]
        
        // TODO
        
        // swiftlint:disable all
        os_log(.default, "Received message from browser.runtime.sendNativeMessage: %@", message as! CVarArg)
        
        // helper that returns json
        func respond(json: String) {
            print("respond", json)
            let response = NSExtensionItem()
            response.userInfo = [ SFExtensionMessageKey: json ]
            context.completeRequest(returningItems: [response], completionHandler: nil)
        }
        func respondError(msg: String) {
            respond(json: "{\"error\": \"\(msg)\"}")
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
            guard let json = try? response.jsonString() else {
                respondError(msg: "Failed to encode gestures")
                return
            }
            respond(json: json)
            return
        }
        if req.loadSettings != nil {
            var gestures: [Gesture] = []
            let gestureRequest = GestureEntity.fetchRequest()
            do {
                let result = try self.moc.fetch(gestureRequest)
                gestures = result.compactMap { $0.gesture }
            } catch {
                respondError(msg: "Failed to fetch gestures")
                return
            }
            var exclusionList: [String] = []
            let exclusionListRequest = ExclusionListEntryEntity.fetchRequest()
            exclusionListRequest.fetchLimit = 1
            do {
                let result = try self.moc.fetch(exclusionListRequest)
                if
                    let entity = result.first,
                    let json = entity.json,
                    let arr = try? ExclusionList.init(json) {
                    exclusionList = arr
                }
            } catch {
                respondError(msg: "Failed to fetch exclusion list")
            }
            let response = LoadSettingsResponse(exclusionList: exclusionList, gestures: gestures)
            guard let json = try? response.jsonString() else {
                respondError(msg: "Failed to encode settings")
                return
            }
            respond(json: json)
            return
        }
        if let requestDetails = req.updateExclusionList {
            guard let json = try? requestDetails.exclusionList.jsonString() else {
                respondError(msg: "Failed to encode given data structure")
                return
            }
            let exclusionListRequest = ExclusionListEntryEntity.fetchRequest()
            exclusionListRequest.fetchLimit = 1
            do {
                let result = try self.moc.fetch(exclusionListRequest)
                let entity = result.first ?? ExclusionListEntryEntity(context: self.moc)
                entity.json = json
                try self.moc.save()
            } catch {
                respondError(msg: "Failed to fetch exclusion list")
            }
            respond(json: "{}")
        }
        respond(json: "Failed to find a request handler")
    }
}
