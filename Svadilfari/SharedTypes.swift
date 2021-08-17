// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let gesture = try Gesture(json)
//   let getGestureResponse = try GetGestureResponse(json)
//   let loadSettingsResponse = try LoadSettingsResponse(json)
//   let messageRequest = try MessageRequest(json)
//   let vector = try Vector(json)
//   let pointList = try PointList(json)
//   let pattern = try Pattern(json)
//   let exclusionList = try ExclusionList(json)
//   let point = try Point(json)
//   let action = try Action(json)

import Foundation

// MARK: - GetGestureResponse
struct GetGestureResponse: Codable {
    var error: String?
    var gestures: [Gesture]?
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
        gestures: [Gesture]?? = nil
    ) -> GetGestureResponse {
        return GetGestureResponse(
            error: error ?? self.error,
            gestures: gestures ?? self.gestures
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Gesture
struct Gesture: Codable {
    var action: Action
    var enabled: Bool
    /// Number of fingers to perform the gesture
    var fingers: Int
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
        fingers: Int? = nil,
        id: String? = nil,
        pattern: Pattern? = nil
    ) -> Gesture {
        return Gesture(
            action: action ?? self.action,
            enabled: enabled ?? self.enabled,
            fingers: fingers ?? self.fingers,
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

// MARK: - Action
struct Action: Codable {
    var javascriptRun: JavascriptRun?
    var reload, scrollBottom, scrollTop, tabClose: Bool?
    var tabCloseAll, tabDuplicate, tabNext, tabOpen: Bool?
    var tabPrevious, urlCopy: Bool?

    enum CodingKeys: String, CodingKey {
        case javascriptRun = "javascript_run"
        case reload
        case scrollBottom = "scroll_bottom"
        case scrollTop = "scroll_top"
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
        javascriptRun: JavascriptRun?? = nil,
        reload: Bool?? = nil,
        scrollBottom: Bool?? = nil,
        scrollTop: Bool?? = nil,
        tabClose: Bool?? = nil,
        tabCloseAll: Bool?? = nil,
        tabDuplicate: Bool?? = nil,
        tabNext: Bool?? = nil,
        tabOpen: Bool?? = nil,
        tabPrevious: Bool?? = nil,
        urlCopy: Bool?? = nil
    ) -> Action {
        return Action(
            javascriptRun: javascriptRun ?? self.javascriptRun,
            reload: reload ?? self.reload,
            scrollBottom: scrollBottom ?? self.scrollBottom,
            scrollTop: scrollTop ?? self.scrollTop,
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

// MARK: - LoadSettingsResponse
struct LoadSettingsResponse: Codable {
    var exclusionList: [String]
    var gestures: [Gesture]

    enum CodingKeys: String, CodingKey {
        case exclusionList = "exclusion_list"
        case gestures
    }
}

// MARK: LoadSettingsResponse convenience initializers and mutators

extension LoadSettingsResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LoadSettingsResponse.self, from: data)
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
        exclusionList: [String]? = nil,
        gestures: [Gesture]? = nil
    ) -> LoadSettingsResponse {
        return LoadSettingsResponse(
            exclusionList: exclusionList ?? self.exclusionList,
            gestures: gestures ?? self.gestures
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
    var getGestures, loadSettings: Bool?
    var updateExclusionList: UpdateExclusionList?

    enum CodingKeys: String, CodingKey {
        case getGestures = "get_gestures"
        case loadSettings = "load_settings"
        case updateExclusionList = "update_exclusion_list"
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
        getGestures: Bool?? = nil,
        loadSettings: Bool?? = nil,
        updateExclusionList: UpdateExclusionList?? = nil
    ) -> MessageRequest {
        return MessageRequest(
            getGestures: getGestures ?? self.getGestures,
            loadSettings: loadSettings ?? self.loadSettings,
            updateExclusionList: updateExclusionList ?? self.updateExclusionList
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - UpdateExclusionList
struct UpdateExclusionList: Codable {
    var exclusionList: [String]

    enum CodingKeys: String, CodingKey {
        case exclusionList = "exclusion_list"
    }
}

// MARK: UpdateExclusionList convenience initializers and mutators

extension UpdateExclusionList {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(UpdateExclusionList.self, from: data)
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
        exclusionList: [String]? = nil
    ) -> UpdateExclusionList {
        return UpdateExclusionList(
            exclusionList: exclusionList ?? self.exclusionList
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
typealias ExclusionList = [String]

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

extension Array where Element == ExclusionList.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ExclusionList.self, from: data)
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
