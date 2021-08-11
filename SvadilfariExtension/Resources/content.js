(() => {
  // src/SharedTypes.ts
  var Convert = class {
    static toGesture(json) {
      return cast(JSON.parse(json), r("Gesture"));
    }
    static gestureToJson(value) {
      return JSON.stringify(uncast(value, r("Gesture")), null, 2);
    }
    static toGetGestureResponse(json) {
      return cast(JSON.parse(json), r("GetGestureResponse"));
    }
    static getGestureResponseToJson(value) {
      return JSON.stringify(uncast(value, r("GetGestureResponse")), null, 2);
    }
    static toMessageRequest(json) {
      return cast(JSON.parse(json), r("MessageRequest"));
    }
    static messageRequestToJson(value) {
      return JSON.stringify(uncast(value, r("MessageRequest")), null, 2);
    }
    static toTabCloseAction(json) {
      return cast(JSON.parse(json), r("TabCloseAction"));
    }
    static tabCloseActionToJson(value) {
      return JSON.stringify(uncast(value, r("TabCloseAction")), null, 2);
    }
    static toReloadAction(json) {
      return cast(JSON.parse(json), r("ReloadAction"));
    }
    static reloadActionToJson(value) {
      return JSON.stringify(uncast(value, r("ReloadAction")), null, 2);
    }
    static toTabNextAction(json) {
      return cast(JSON.parse(json), r("TabNextAction"));
    }
    static tabNextActionToJson(value) {
      return JSON.stringify(uncast(value, r("TabNextAction")), null, 2);
    }
    static toTabPreviousAction(json) {
      return cast(JSON.parse(json), r("TabPreviousAction"));
    }
    static tabPreviousActionToJson(value) {
      return JSON.stringify(uncast(value, r("TabPreviousAction")), null, 2);
    }
    static toRunJavaScriptAction(json) {
      return cast(JSON.parse(json), r("RunJavaScriptAction"));
    }
    static runJavaScriptActionToJson(value) {
      return JSON.stringify(uncast(value, r("RunJavaScriptAction")), null, 2);
    }
    static toVector(json) {
      return cast(JSON.parse(json), r("Vector"));
    }
    static vectorToJson(value) {
      return JSON.stringify(uncast(value, r("Vector")), null, 2);
    }
    static toPattern(json) {
      return cast(JSON.parse(json), r("Pattern"));
    }
    static patternToJson(value) {
      return JSON.stringify(uncast(value, r("Pattern")), null, 2);
    }
    static toPoint(json) {
      return cast(JSON.parse(json), r("Point"));
    }
    static pointToJson(value) {
      return JSON.stringify(uncast(value, r("Point")), null, 2);
    }
    static toAction(json) {
      return cast(JSON.parse(json), r("Action"));
    }
    static actionToJson(value) {
      return JSON.stringify(uncast(value, r("Action")), null, 2);
    }
  };
  function invalidValue(typ, val, key = "") {
    if (key) {
      throw Error(`Invalid value for key "${key}". Expected type ${JSON.stringify(typ)} but got ${JSON.stringify(val)}`);
    }
    throw Error(`Invalid value ${JSON.stringify(val)} for type ${JSON.stringify(typ)}`);
  }
  function jsonToJSProps(typ) {
    if (typ.jsonToJS === void 0) {
      const map = {};
      typ.props.forEach((p) => map[p.json] = { key: p.js, typ: p.typ });
      typ.jsonToJS = map;
    }
    return typ.jsonToJS;
  }
  function jsToJSONProps(typ) {
    if (typ.jsToJSON === void 0) {
      const map = {};
      typ.props.forEach((p) => map[p.js] = { key: p.json, typ: p.typ });
      typ.jsToJSON = map;
    }
    return typ.jsToJSON;
  }
  function transform(val, typ, getProps, key = "") {
    function transformPrimitive(typ2, val2) {
      if (typeof typ2 === typeof val2)
        return val2;
      return invalidValue(typ2, val2, key);
    }
    function transformUnion(typs, val2) {
      const l = typs.length;
      for (let i = 0; i < l; i++) {
        const typ2 = typs[i];
        try {
          return transform(val2, typ2, getProps);
        } catch (_) {
        }
      }
      return invalidValue(typs, val2);
    }
    function transformEnum(cases, val2) {
      if (cases.indexOf(val2) !== -1)
        return val2;
      return invalidValue(cases, val2);
    }
    function transformArray(typ2, val2) {
      if (!Array.isArray(val2))
        return invalidValue("array", val2);
      return val2.map((el) => transform(el, typ2, getProps));
    }
    function transformDate(val2) {
      if (val2 === null) {
        return null;
      }
      const d = new Date(val2);
      if (isNaN(d.valueOf())) {
        return invalidValue("Date", val2);
      }
      return d;
    }
    function transformObject(props, additional, val2) {
      if (val2 === null || typeof val2 !== "object" || Array.isArray(val2)) {
        return invalidValue("object", val2);
      }
      const result = {};
      Object.getOwnPropertyNames(props).forEach((key2) => {
        const prop = props[key2];
        const v = Object.prototype.hasOwnProperty.call(val2, key2) ? val2[key2] : void 0;
        result[prop.key] = transform(v, prop.typ, getProps, prop.key);
      });
      Object.getOwnPropertyNames(val2).forEach((key2) => {
        if (!Object.prototype.hasOwnProperty.call(props, key2)) {
          result[key2] = transform(val2[key2], additional, getProps, key2);
        }
      });
      return result;
    }
    if (typ === "any")
      return val;
    if (typ === null) {
      if (val === null)
        return val;
      return invalidValue(typ, val);
    }
    if (typ === false)
      return invalidValue(typ, val);
    while (typeof typ === "object" && typ.ref !== void 0) {
      typ = typeMap[typ.ref];
    }
    if (Array.isArray(typ))
      return transformEnum(typ, val);
    if (typeof typ === "object") {
      return typ.hasOwnProperty("unionMembers") ? transformUnion(typ.unionMembers, val) : typ.hasOwnProperty("arrayItems") ? transformArray(typ.arrayItems, val) : typ.hasOwnProperty("props") ? transformObject(getProps(typ), typ.additional, val) : invalidValue(typ, val);
    }
    if (typ === Date && typeof val !== "number")
      return transformDate(val);
    return transformPrimitive(typ, val);
  }
  function cast(val, typ) {
    return transform(val, typ, jsonToJSProps);
  }
  function uncast(val, typ) {
    return transform(val, typ, jsToJSONProps);
  }
  function a(typ) {
    return { arrayItems: typ };
  }
  function u(...typs) {
    return { unionMembers: typs };
  }
  function o(props, additional) {
    return { props, additional };
  }
  function r(name) {
    return { ref: name };
  }
  var typeMap = {
    "GetGestureResponse": o([
      { json: "error", js: "error", typ: u(void 0, "") },
      { json: "gestures", js: "gestures", typ: u(void 0, a(r("Gesture"))) }
    ], "any"),
    "Gesture": o([
      { json: "action", js: "action", typ: r("Action") },
      { json: "enabled", js: "enabled", typ: true },
      { json: "fingers", js: "fingers", typ: 0 },
      { json: "id", js: "id", typ: "" },
      { json: "pattern", js: "pattern", typ: r("Pattern") }
    ], "any"),
    "Action": o([
      { json: "reload", js: "reload", typ: u(void 0, r("ReloadAction")) },
      { json: "run_javascript", js: "runJavascript", typ: u(void 0, r("RunJavaScriptAction")) },
      { json: "tab_close", js: "tabClose", typ: u(void 0, r("TabCloseAction")) },
      { json: "tab_next", js: "tabNext", typ: u(void 0, r("TabNextAction")) },
      { json: "tab_previous", js: "tabPrevious", typ: u(void 0, r("TabPreviousAction")) }
    ], "any"),
    "ReloadAction": o([
      { json: "action", js: "action", typ: true }
    ], "any"),
    "RunJavaScriptAction": o([
      { json: "action", js: "action", typ: true },
      { json: "code", js: "code", typ: "" },
      { json: "description", js: "description", typ: u(void 0, "") }
    ], "any"),
    "TabCloseAction": o([
      { json: "action", js: "action", typ: true }
    ], "any"),
    "TabNextAction": o([
      { json: "action", js: "action", typ: true }
    ], "any"),
    "TabPreviousAction": o([
      { json: "action", js: "action", typ: true }
    ], "any"),
    "Pattern": o([
      { json: "data", js: "data", typ: a(r("Vector")) }
    ], "any"),
    "Vector": o([
      { json: "x", js: "x", typ: 3.14 },
      { json: "y", js: "y", typ: 3.14 }
    ], "any"),
    "MessageRequest": o([
      { json: "get_gestures", js: "getGestures", typ: u(void 0, true) }
    ], "any"),
    "Point": o([
      { json: "x", js: "x", typ: 3.14 },
      { json: "y", js: "y", typ: 3.14 }
    ], "any")
  };

  // src/content/messenger/ContentMessanger.ts
  var ContentMessangerImpl = class {
    async getGesture() {
      const req = { getGestures: true };
      const msg = {
        type: "NATIVE_PROXY",
        payload: Convert.messageRequestToJson(req)
      };
      const responseStr = await browser.runtime.sendMessage(msg);
      const res = Convert.toGetGestureResponse(responseStr);
      return res;
    }
  };

  // src/content/content.ts
  console.log("hello from content");
  var messanger = new ContentMessangerImpl();
  messanger.getGesture().then((x) => {
    console.log("loaded", x);
  }).catch((e) => {
    console.warn(e);
  });
})();
