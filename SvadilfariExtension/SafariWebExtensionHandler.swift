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
        respond(json: "Failed to find a request handler")
    }
}
