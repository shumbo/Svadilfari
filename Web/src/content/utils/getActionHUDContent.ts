import ArrowCircleLeft from "@fluentui/svg-icons/icons/arrow_circle_left_24_regular.svg";
import ArrowCircleRight from "@fluentui/svg-icons/icons/arrow_circle_right_24_regular.svg";
import ArrowClockwise from "@fluentui/svg-icons/icons/arrow_clockwise_20_regular.svg";
import ArrowCurveDownRight from "@fluentui/svg-icons/icons/arrow_curve_down_right_20_regular.svg";
import ArrowCurveUpLeft from "@fluentui/svg-icons/icons/arrow_curve_up_left_20_regular.svg";
import Broom from "@fluentui/svg-icons/icons/broom_20_regular.svg";
import ClipboardLink from "@fluentui/svg-icons/icons/clipboard_link_20_regular.svg";
import Code from "@fluentui/svg-icons/icons/code_20_filled.svg";
import TabAdd from "@fluentui/svg-icons/icons/tab_add_20_regular.svg";
import TabDesktopCopy from "@fluentui/svg-icons/icons/tab_desktop_copy_20_regular.svg";
import TabProhibited from "@fluentui/svg-icons/icons/tab_prohibited_24_regular.svg";
import { HUDContent } from "../../components/HUD/HUD";
import { Action } from "../../SharedTypes";
import { assertUnreachable } from "../../utils/assertUnreachable";
import { getActionCode } from "../../utils/getActionCode";

export function getActionHUDContent(action: Action): HUDContent {
  const key = getActionCode(action);
  switch (key) {
    case "tabClose":
      return { title: "Close Tab", icon: TabProhibited };
    case "tabCloseAll":
      return { title: "Close All Tabs", icon: Broom };
    case "tabOpen":
      return { title: "Open New Tab", icon: TabAdd };
    case "tabDuplicate":
      return { title: "Duplicate Tab", icon: TabDesktopCopy };
    case "tabNext":
      return { title: "Next Tab", icon: ArrowCircleRight };
    case "tabPrevious":
      return { title: "Previous Tab", icon: ArrowCircleLeft };
    case "reload":
      return { title: "Reload", icon: ArrowClockwise };
    case "javascriptRun": {
      const c: HUDContent = { title: "Run JavaScript", icon: Code };
      if (action?.javascriptRun?.description) {
        c.message = action.javascriptRun.description;
      }
      return c;
    }
    case "urlCopy":
      return { title: "Copy URL", icon: ClipboardLink };
    case "scrollTop":
      return { title: "Scroll to Top", icon: ArrowCurveUpLeft };
    case "scrollBottom":
      return { title: "Scroll to Bottom", icon: ArrowCurveDownRight };
    case null:
      break;
    default:
      assertUnreachable(key);
  }
  return { title: "Unknown Action" };
}
