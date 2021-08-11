// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let gesture = try Gesture(json)
//   let getGestureResponse = try GetGestureResponse(json)
//   let messageRequest = try MessageRequest(json)
//   let tabCloseAction = try TabCloseAction(json)
//   let reloadAction = try ReloadAction(json)
//   let tabNextAction = try TabNextAction(json)
//   let tabPreviousAction = try TabPreviousAction(json)
//   let runJavaScriptAction = try RunJavaScriptAction(json)
//   let vector = try Vector(json)
//   let pattern = try Pattern(json)
//   let point = try Point(json)
//   let action = try Action(json)

import Foundation

// MARK: - GetGestureResponse
struct GetGestureResponse: Codable {
    let error: String?
    let gestures: [Gesture]?
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
    let action: Action
    let enabled: Bool
    /// Number of fingers to perform the gesture
    let fingers: Int
    let id: String
    let pattern: Pattern
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
    let reload: ReloadAction?
    let runJavascript: RunJavaScriptAction?
    let tabClose: TabCloseAction?
    let tabNext: TabNextAction?
    let tabPrevious: TabPreviousAction?

    enum CodingKeys: String, CodingKey {
        case reload
        case runJavascript = "run_javascript"
        case tabClose = "tab_close"
        case tabNext = "tab_next"
        case tabPrevious = "tab_previous"
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
        reload: ReloadAction?? = nil,
        runJavascript: RunJavaScriptAction?? = nil,
        tabClose: TabCloseAction?? = nil,
        tabNext: TabNextAction?? = nil,
        tabPrevious: TabPreviousAction?? = nil
    ) -> Action {
        return Action(
            reload: reload ?? self.reload,
            runJavascript: runJavascript ?? self.runJavascript,
            tabClose: tabClose ?? self.tabClose,
            tabNext: tabNext ?? self.tabNext,
            tabPrevious: tabPrevious ?? self.tabPrevious
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ReloadAction
struct ReloadAction: Codable {
    let action: Bool
}

// MARK: ReloadAction convenience initializers and mutators

extension ReloadAction {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ReloadAction.self, from: data)
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
        action: Bool? = nil
    ) -> ReloadAction {
        return ReloadAction(
            action: action ?? self.action
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - RunJavaScriptAction
struct RunJavaScriptAction: Codable {
    let action: Bool
    let code: String
    let runJavaScriptActionDescription: String?

    enum CodingKeys: String, CodingKey {
        case action, code
        case runJavaScriptActionDescription = "description"
    }
}

// MARK: RunJavaScriptAction convenience initializers and mutators

extension RunJavaScriptAction {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RunJavaScriptAction.self, from: data)
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
        action: Bool? = nil,
        code: String? = nil,
        runJavaScriptActionDescription: String?? = nil
    ) -> RunJavaScriptAction {
        return RunJavaScriptAction(
            action: action ?? self.action,
            code: code ?? self.code,
            runJavaScriptActionDescription: runJavaScriptActionDescription ?? self.runJavaScriptActionDescription
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - TabCloseAction
struct TabCloseAction: Codable {
    let action: Bool
}

// MARK: TabCloseAction convenience initializers and mutators

extension TabCloseAction {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TabCloseAction.self, from: data)
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
        action: Bool? = nil
    ) -> TabCloseAction {
        return TabCloseAction(
            action: action ?? self.action
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - TabNextAction
struct TabNextAction: Codable {
    let action: Bool
}

// MARK: TabNextAction convenience initializers and mutators

extension TabNextAction {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TabNextAction.self, from: data)
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
        action: Bool? = nil
    ) -> TabNextAction {
        return TabNextAction(
            action: action ?? self.action
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - TabPreviousAction
struct TabPreviousAction: Codable {
    let action: Bool
}

// MARK: TabPreviousAction convenience initializers and mutators

extension TabPreviousAction {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TabPreviousAction.self, from: data)
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
        action: Bool? = nil
    ) -> TabPreviousAction {
        return TabPreviousAction(
            action: action ?? self.action
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
    let data: [Vector]
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
    let x, y: Double
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

/// Request from Web Extension to App
// MARK: - MessageRequest
struct MessageRequest: Codable {
    let getGestures: Bool?

    enum CodingKeys: String, CodingKey {
        case getGestures = "get_gestures"
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
        getGestures: Bool?? = nil
    ) -> MessageRequest {
        return MessageRequest(
            getGestures: getGestures ?? self.getGestures
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
    let x, y: Double
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
