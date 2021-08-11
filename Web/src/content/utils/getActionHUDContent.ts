import { HUDContent } from "../../components/HUD/HUD";
import { Action } from "../../SharedTypes";
import ArrowClockwise from "@fluentui/svg-icons/icons/arrow_clockwise_20_regular.svg";
import Code from "@fluentui/svg-icons/icons/code_20_filled.svg";

export function getActionHUDContent(action: Action): HUDContent {
  if (action.reload) {
    return { title: "Reload", icon: ArrowClockwise };
  }
  if (action.runJavascript) {
    const c: HUDContent = { title: "Run JavaScript", icon: Code };
    if (action.runJavascript.description) {
      c.message = action.runJavascript.description;
    }
    return c;
  }
  return { title: "Unknown Action" };
}
