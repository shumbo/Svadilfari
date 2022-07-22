// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let gesture = try Gesture(json)
//   let getGestureResponse = try GetGestureResponse(json)
//   let getExclusionEntryResponse = try GetExclusionEntryResponse(json)
//   let messageRequest = try MessageRequest(json)
//   let pointList = try PointList(json)
//   let vector = try Vector(json)
//   let pattern = try Pattern(json)
//   let point = try Point(json)
//   let action = try Action(json)

import Foundation

// MARK: - GetGestureResponse
struct GetGestureResponse: Codable {
    var error: String?
    var gestures: [Gesture]
    /// True if extension should detect gesture with mouse
    var mouse: Bool
    /// Gesture Recognition Sensitivity ([-3, 3])
    var sensitivity: Double
}

// MARK: GetGestureResponse convenience initializers and mutators

extension GetGestureResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(GetGestureResponse.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        error: String?? = nil,
        gestures: [Gesture]? = nil,
        mouse: Bool? = nil,
        sensitivity: Double? = nil
    ) -> GetGestureResponse {
        return GetGestureResponse(
            error: error ?? self.error,
            gestures: gestures ?? self.gestures,
            mouse: mouse ?? self.mouse,
            sensitivity: sensitivity ?? self.sensitivity
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// Gesture represents a configuration of the gesture, which is a pair of a pattern and
/// action, plus some additional information
// MARK: - Gesture
struct Gesture: Codable {
    var action: Action
    var enabled: Bool
    var id: String
    var pattern: Pattern
}

// MARK: Gesture convenience initializers and mutators

extension Gesture {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Gesture.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        action: Action? = nil,
        enabled: Bool? = nil,
        id: String? = nil,
        pattern: Pattern? = nil
    ) -> Gesture {
        return Gesture(
            action: action ?? self.action,
            enabled: enabled ?? self.enabled,
            id: id ?? self.id,
            pattern: pattern ?? self.pattern
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// Action represents an action that can be performed on a website. It should have a non-null
/// value exactly one property.
// MARK: - Action
struct Action: Codable {
    var goBackward, goForward: Bool?
    var javascriptRun: JavascriptRun?
    var openURL: OpenURLAction?
    var reload, scrollBottom, scrollTop, share: Bool?
    var tabClose, tabCloseAll, tabDuplicate, tabNext: Bool?
    var tabOpen, tabPrevious, urlCopy: Bool?

    enum CodingKeys: String, CodingKey {
        case goBackward = "go_backward"
        case goForward = "go_forward"
        case javascriptRun = "javascript_run"
        case openURL = "open_url"
        case reload
        case scrollBottom = "scroll_bottom"
        case scrollTop = "scroll_top"
        case share
        case tabClose = "tab_close"
        case tabCloseAll = "tab_close_all"
        case tabDuplicate = "tab_duplicate"
        case tabNext = "tab_next"
        case tabOpen = "tab_open"
        case tabPrevious = "tab_previous"
        case urlCopy = "url_copy"
    }
}

// MARK: Action convenience initializers and mutators

extension Action {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Action.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        goBackward: Bool?? = nil,
        goForward: Bool?? = nil,
        javascriptRun: JavascriptRun?? = nil,
        openURL: OpenURLAction?? = nil,
        reload: Bool?? = nil,
        scrollBottom: Bool?? = nil,
        scrollTop: Bool?? = nil,
        share: Bool?? = nil,
        tabClose: Bool?? = nil,
        tabCloseAll: Bool?? = nil,
        tabDuplicate: Bool?? = nil,
        tabNext: Bool?? = nil,
        tabOpen: Bool?? = nil,
        tabPrevious: Bool?? = nil,
        urlCopy: Bool?? = nil
    ) -> Action {
        return Action(
            goBackward: goBackward ?? self.goBackward,
            goForward: goForward ?? self.goForward,
            javascriptRun: javascriptRun ?? self.javascriptRun,
            openURL: openURL ?? self.openURL,
            reload: reload ?? self.reload,
            scrollBottom: scrollBottom ?? self.scrollBottom,
            scrollTop: scrollTop ?? self.scrollTop,
            share: share ?? self.share,
            tabClose: tabClose ?? self.tabClose,
            tabCloseAll: tabCloseAll ?? self.tabCloseAll,
            tabDuplicate: tabDuplicate ?? self.tabDuplicate,
            tabNext: tabNext ?? self.tabNext,
            tabOpen: tabOpen ?? self.tabOpen,
            tabPrevious: tabPrevious ?? self.tabPrevious,
            urlCopy: urlCopy ?? self.urlCopy
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - JavascriptRun
struct JavascriptRun: Codable {
    var code: String
    var javascriptRunDescription: String?

    enum CodingKeys: String, CodingKey {
        case code
        case javascriptRunDescription = "description"
    }
}

// MARK: JavascriptRun convenience initializers and mutators

extension JavascriptRun {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(JavascriptRun.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        code: String? = nil,
        javascriptRunDescription: String?? = nil
    ) -> JavascriptRun {
        return JavascriptRun(
            code: code ?? self.code,
            javascriptRunDescription: javascriptRunDescription ?? self.javascriptRunDescription
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - OpenURLAction
struct OpenURLAction: Codable {
    var newTab: Bool
    var title, url: String

    enum CodingKeys: String, CodingKey {
        case newTab = "new_tab"
        case title, url
    }
}

// MARK: OpenURLAction convenience initializers and mutators

extension OpenURLAction {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(OpenURLAction.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        newTab: Bool? = nil,
        title: String? = nil,
        url: String? = nil
    ) -> OpenURLAction {
        return OpenURLAction(
            newTab: newTab ?? self.newTab,
            title: title ?? self.title,
            url: url ?? self.url
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Pattern
struct Pattern: Codable {
    var data: [Vector]
}

// MARK: Pattern convenience initializers and mutators

extension Pattern {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Pattern.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        data: [Vector]? = nil
    ) -> Pattern {
        return Pattern(
            data: data ?? self.data
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Vector
struct Vector: Codable {
    var x, y: Double
}

// MARK: Vector convenience initializers and mutators

extension Vector {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Vector.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        x: Double? = nil,
        y: Double? = nil
    ) -> Vector {
        return Vector(
            x: x ?? self.x,
            y: y ?? self.y
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - GetExclusionEntryResponse
struct GetExclusionEntryResponse: Codable {
    var exclusionEntry: GetExclusionEntryResponseExclusionEntry?

    enum CodingKeys: String, CodingKey {
        case exclusionEntry = "exclusion_entry"
    }
}

// MARK: GetExclusionEntryResponse convenience initializers and mutators

extension GetExclusionEntryResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(GetExclusionEntryResponse.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        exclusionEntry: GetExclusionEntryResponseExclusionEntry?? = nil
    ) -> GetExclusionEntryResponse {
        return GetExclusionEntryResponse(
            exclusionEntry: exclusionEntry ?? self.exclusionEntry
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - GetExclusionEntryResponseExclusionEntry
struct GetExclusionEntryResponseExclusionEntry: Codable {
    var domain, id: String
    var path: String?
}

// MARK: GetExclusionEntryResponseExclusionEntry convenience initializers and mutators

extension GetExclusionEntryResponseExclusionEntry {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(GetExclusionEntryResponseExclusionEntry.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        domain: String? = nil,
        id: String? = nil,
        path: String?? = nil
    ) -> GetExclusionEntryResponseExclusionEntry {
        return GetExclusionEntryResponseExclusionEntry(
            domain: domain ?? self.domain,
            id: id ?? self.id,
            path: path ?? self.path
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// Request from Web Extension to App
// MARK: - MessageRequest
struct MessageRequest: Codable {
    var addExclusionEntry: AddExclusionEntryRequest?
    /// Request the relevant exclusion list entry
    ///
    /// If the domain is excluded, return domain exclusion entry
    /// If the page is excluded, return the page exclusion entry
    /// If the extension is active on the given page, return null
    var getExclusionEntry: GetExclusionEntryRequest?
    var getGestures: Bool?
    var removeExclusionEntry: RemoveExclusionEntryRequest?

    enum CodingKeys: String, CodingKey {
        case addExclusionEntry = "add_exclusion_entry"
        case getExclusionEntry = "get_exclusion_entry"
        case getGestures = "get_gestures"
        case removeExclusionEntry = "remove_exclusion_entry"
    }
}

// MARK: MessageRequest convenience initializers and mutators

extension MessageRequest {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MessageRequest.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        addExclusionEntry: AddExclusionEntryRequest?? = nil,
        getExclusionEntry: GetExclusionEntryRequest?? = nil,
        getGestures: Bool?? = nil,
        removeExclusionEntry: RemoveExclusionEntryRequest?? = nil
    ) -> MessageRequest {
        return MessageRequest(
            addExclusionEntry: addExclusionEntry ?? self.addExclusionEntry,
            getExclusionEntry: getExclusionEntry ?? self.getExclusionEntry,
            getGestures: getGestures ?? self.getGestures,
            removeExclusionEntry: removeExclusionEntry ?? self.removeExclusionEntry
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - AddExclusionEntryRequest
struct AddExclusionEntryRequest: Codable {
    var domain: String
    var path: String?
}

// MARK: AddExclusionEntryRequest convenience initializers and mutators

extension AddExclusionEntryRequest {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AddExclusionEntryRequest.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        domain: String? = nil,
        path: String?? = nil
    ) -> AddExclusionEntryRequest {
        return AddExclusionEntryRequest(
            domain: domain ?? self.domain,
            path: path ?? self.path
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

/// Request the relevant exclusion list entry
///
/// If the domain is excluded, return domain exclusion entry
/// If the page is excluded, return the page exclusion entry
/// If the extension is active on the given page, return null
// MARK: - GetExclusionEntryRequest
struct GetExclusionEntryRequest: Codable {
    var domain, path: String
}

// MARK: GetExclusionEntryRequest convenience initializers and mutators

extension GetExclusionEntryRequest {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(GetExclusionEntryRequest.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        domain: String? = nil,
        path: String? = nil
    ) -> GetExclusionEntryRequest {
        return GetExclusionEntryRequest(
            domain: domain ?? self.domain,
            path: path ?? self.path
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - RemoveExclusionEntryRequest
struct RemoveExclusionEntryRequest: Codable {
    var id: String
}

// MARK: RemoveExclusionEntryRequest convenience initializers and mutators

extension RemoveExclusionEntryRequest {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RemoveExclusionEntryRequest.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String? = nil
    ) -> RemoveExclusionEntryRequest {
        return RemoveExclusionEntryRequest(
            id: id ?? self.id
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Point
struct Point: Codable {
    var x, y: Double
}

// MARK: Point convenience initializers and mutators

extension Point {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Point.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        x: Double? = nil,
        y: Double? = nil
    ) -> Point {
        return Point(
            x: x ?? self.x,
            y: y ?? self.y
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias PointList = [Point]

extension Array where Element == PointList.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PointList.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
