// To parse this data:
//
//   import { Convert, Gesture, GetGestureResponse, LoadSettingsResponse, MessageRequest, Vector, Pattern, Point, Action } from "./file";
//
//   const gesture = Convert.toGesture(json);
//   const getGestureResponse = Convert.toGetGestureResponse(json);
//   const loadSettingsResponse = Convert.toLoadSettingsResponse(json);
//   const messageRequest = Convert.toMessageRequest(json);
//   const vector = Convert.toVector(json);
//   const pointList = Convert.toPointList(json);
//   const pattern = Convert.toPattern(json);
//   const exclusionList = Convert.toExclusionList(json);
//   const point = Convert.toPoint(json);
//   const action = Convert.toAction(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

export interface GetGestureResponse {
    error?:    string;
    gestures?: Gesture[];
}

export interface Gesture {
    action:  Action;
    enabled: boolean;
    /**
     * Number of fingers to perform the gesture
     */
    fingers: number;
    id:      string;
    pattern: Pattern;
}

export interface Action {
    javascriptRun?: JavascriptRun;
    reload?:        boolean;
    scrollBottom?:  boolean;
    scrollTop?:     boolean;
    tabClose?:      boolean;
    tabCloseAll?:   boolean;
    tabDuplicate?:  boolean;
    tabNext?:       boolean;
    tabOpen?:       boolean;
    tabPrevious?:   boolean;
    urlCopy?:       boolean;
}

export interface JavascriptRun {
    code:         string;
    description?: string;
}

export interface Pattern {
    data: Vector[];
}

export interface Vector {
    x: number;
    y: number;
}

export interface LoadSettingsResponse {
    exclusionList: string[];
    gestures:      Gesture[];
}

/**
 * Request from Web Extension to App
 */
export interface MessageRequest {
    getGestures?:         boolean;
    loadSettings?:        boolean;
    updateExclusionList?: UpdateExclusionList;
}

export interface UpdateExclusionList {
    exclusionList: string[];
}

export interface Point {
    x: number;
    y: number;
}

// Converts JSON strings to/from your types
// and asserts the results of JSON.parse at runtime
export class Convert {
    public static toGesture(json: string): Gesture {
        return cast(JSON.parse(json), r("Gesture"));
    }

    public static gestureToJson(value: Gesture): string {
        return JSON.stringify(uncast(value, r("Gesture")), null, 2);
    }

    public static toGetGestureResponse(json: string): GetGestureResponse {
        return cast(JSON.parse(json), r("GetGestureResponse"));
    }

    public static getGestureResponseToJson(value: GetGestureResponse): string {
        return JSON.stringify(uncast(value, r("GetGestureResponse")), null, 2);
    }

    public static toLoadSettingsResponse(json: string): LoadSettingsResponse {
        return cast(JSON.parse(json), r("LoadSettingsResponse"));
    }

    public static loadSettingsResponseToJson(value: LoadSettingsResponse): string {
        return JSON.stringify(uncast(value, r("LoadSettingsResponse")), null, 2);
    }

    public static toMessageRequest(json: string): MessageRequest {
        return cast(JSON.parse(json), r("MessageRequest"));
    }

    public static messageRequestToJson(value: MessageRequest): string {
        return JSON.stringify(uncast(value, r("MessageRequest")), null, 2);
    }

    public static toVector(json: string): Vector {
        return cast(JSON.parse(json), r("Vector"));
    }

    public static vectorToJson(value: Vector): string {
        return JSON.stringify(uncast(value, r("Vector")), null, 2);
    }

    public static toPointList(json: string): Point[] {
        return cast(JSON.parse(json), a(r("Point")));
    }

    public static pointListToJson(value: Point[]): string {
        return JSON.stringify(uncast(value, a(r("Point"))), null, 2);
    }

    public static toPattern(json: string): Pattern {
        return cast(JSON.parse(json), r("Pattern"));
    }

    public static patternToJson(value: Pattern): string {
        return JSON.stringify(uncast(value, r("Pattern")), null, 2);
    }

    public static toExclusionList(json: string): string[] {
        return cast(JSON.parse(json), a(""));
    }

    public static exclusionListToJson(value: string[]): string {
        return JSON.stringify(uncast(value, a("")), null, 2);
    }

    public static toPoint(json: string): Point {
        return cast(JSON.parse(json), r("Point"));
    }

    public static pointToJson(value: Point): string {
        return JSON.stringify(uncast(value, r("Point")), null, 2);
    }

    public static toAction(json: string): Action {
        return cast(JSON.parse(json), r("Action"));
    }

    public static actionToJson(value: Action): string {
        return JSON.stringify(uncast(value, r("Action")), null, 2);
    }
}

function invalidValue(typ: any, val: any, key: any = ''): never {
    if (key) {
        throw Error(`Invalid value for key "${key}". Expected type ${JSON.stringify(typ)} but got ${JSON.stringify(val)}`);
    }
    throw Error(`Invalid value ${JSON.stringify(val)} for type ${JSON.stringify(typ)}`, );
}

function jsonToJSProps(typ: any): any {
    if (typ.jsonToJS === undefined) {
        const map: any = {};
        typ.props.forEach((p: any) => map[p.json] = { key: p.js, typ: p.typ });
        typ.jsonToJS = map;
    }
    return typ.jsonToJS;
}

function jsToJSONProps(typ: any): any {
    if (typ.jsToJSON === undefined) {
        const map: any = {};
        typ.props.forEach((p: any) => map[p.js] = { key: p.json, typ: p.typ });
        typ.jsToJSON = map;
    }
    return typ.jsToJSON;
}

function transform(val: any, typ: any, getProps: any, key: any = ''): any {
    function transformPrimitive(typ: string, val: any): any {
        if (typeof typ === typeof val) return val;
        return invalidValue(typ, val, key);
    }

    function transformUnion(typs: any[], val: any): any {
        // val must validate against one typ in typs
        const l = typs.length;
        for (let i = 0; i < l; i++) {
            const typ = typs[i];
            try {
                return transform(val, typ, getProps);
            } catch (_) {}
        }
        return invalidValue(typs, val);
    }

    function transformEnum(cases: string[], val: any): any {
        if (cases.indexOf(val) !== -1) return val;
        return invalidValue(cases, val);
    }

    function transformArray(typ: any, val: any): any {
        // val must be an array with no invalid elements
        if (!Array.isArray(val)) return invalidValue("array", val);
        return val.map(el => transform(el, typ, getProps));
    }

    function transformDate(val: any): any {
        if (val === null) {
            return null;
        }
        const d = new Date(val);
        if (isNaN(d.valueOf())) {
            return invalidValue("Date", val);
        }
        return d;
    }

    function transformObject(props: { [k: string]: any }, additional: any, val: any): any {
        if (val === null || typeof val !== "object" || Array.isArray(val)) {
            return invalidValue("object", val);
        }
        const result: any = {};
        Object.getOwnPropertyNames(props).forEach(key => {
            const prop = props[key];
            const v = Object.prototype.hasOwnProperty.call(val, key) ? val[key] : undefined;
            result[prop.key] = transform(v, prop.typ, getProps, prop.key);
        });
        Object.getOwnPropertyNames(val).forEach(key => {
            if (!Object.prototype.hasOwnProperty.call(props, key)) {
                result[key] = transform(val[key], additional, getProps, key);
            }
        });
        return result;
    }

    if (typ === "any") return val;
    if (typ === null) {
        if (val === null) return val;
        return invalidValue(typ, val);
    }
    if (typ === false) return invalidValue(typ, val);
    while (typeof typ === "object" && typ.ref !== undefined) {
        typ = typeMap[typ.ref];
    }
    if (Array.isArray(typ)) return transformEnum(typ, val);
    if (typeof typ === "object") {
        return typ.hasOwnProperty("unionMembers") ? transformUnion(typ.unionMembers, val)
            : typ.hasOwnProperty("arrayItems")    ? transformArray(typ.arrayItems, val)
            : typ.hasOwnProperty("props")         ? transformObject(getProps(typ), typ.additional, val)
            : invalidValue(typ, val);
    }
    // Numbers can be parsed by Date but shouldn't be.
    if (typ === Date && typeof val !== "number") return transformDate(val);
    return transformPrimitive(typ, val);
}

function cast<T>(val: any, typ: any): T {
    return transform(val, typ, jsonToJSProps);
}

function uncast<T>(val: T, typ: any): any {
    return transform(val, typ, jsToJSONProps);
}

function a(typ: any) {
    return { arrayItems: typ };
}

function u(...typs: any[]) {
    return { unionMembers: typs };
}

function o(props: any[], additional: any) {
    return { props, additional };
}

function m(additional: any) {
    return { props: [], additional };
}

function r(name: string) {
    return { ref: name };
}

const typeMap: any = {
    "GetGestureResponse": o([
        { json: "error", js: "error", typ: u(undefined, "") },
        { json: "gestures", js: "gestures", typ: u(undefined, a(r("Gesture"))) },
    ], "any"),
    "Gesture": o([
        { json: "action", js: "action", typ: r("Action") },
        { json: "enabled", js: "enabled", typ: true },
        { json: "fingers", js: "fingers", typ: 0 },
        { json: "id", js: "id", typ: "" },
        { json: "pattern", js: "pattern", typ: r("Pattern") },
    ], "any"),
    "Action": o([
        { json: "javascript_run", js: "javascriptRun", typ: u(undefined, r("JavascriptRun")) },
        { json: "reload", js: "reload", typ: u(undefined, true) },
        { json: "scroll_bottom", js: "scrollBottom", typ: u(undefined, true) },
        { json: "scroll_top", js: "scrollTop", typ: u(undefined, true) },
        { json: "tab_close", js: "tabClose", typ: u(undefined, true) },
        { json: "tab_close_all", js: "tabCloseAll", typ: u(undefined, true) },
        { json: "tab_duplicate", js: "tabDuplicate", typ: u(undefined, true) },
        { json: "tab_next", js: "tabNext", typ: u(undefined, true) },
        { json: "tab_open", js: "tabOpen", typ: u(undefined, true) },
        { json: "tab_previous", js: "tabPrevious", typ: u(undefined, true) },
        { json: "url_copy", js: "urlCopy", typ: u(undefined, true) },
    ], "any"),
    "JavascriptRun": o([
        { json: "code", js: "code", typ: "" },
        { json: "description", js: "description", typ: u(undefined, "") },
    ], "any"),
    "Pattern": o([
        { json: "data", js: "data", typ: a(r("Vector")) },
    ], "any"),
    "Vector": o([
        { json: "x", js: "x", typ: 3.14 },
        { json: "y", js: "y", typ: 3.14 },
    ], "any"),
    "LoadSettingsResponse": o([
        { json: "exclusion_list", js: "exclusionList", typ: a("") },
        { json: "gestures", js: "gestures", typ: a(r("Gesture")) },
    ], "any"),
    "MessageRequest": o([
        { json: "get_gestures", js: "getGestures", typ: u(undefined, true) },
        { json: "load_settings", js: "loadSettings", typ: u(undefined, true) },
        { json: "update_exclusion_list", js: "updateExclusionList", typ: u(undefined, r("UpdateExclusionList")) },
    ], "any"),
    "UpdateExclusionList": o([
        { json: "exclusion_list", js: "exclusionList", typ: a("") },
    ], "any"),
    "Point": o([
        { json: "x", js: "x", typ: 3.14 },
        { json: "y", js: "y", typ: 3.14 },
    ], "any"),
};
