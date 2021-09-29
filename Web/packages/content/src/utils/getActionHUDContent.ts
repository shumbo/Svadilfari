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
import { Browser } from "webextension-typedef";
import { HUDContent } from "../components/HUD/HUD";
import { Action } from "../../../../../WebExtension/src/SharedTypes";
import { assertUnreachable } from "../../../../../WebExtension/src/utils/assertUnreachable";
import { getActionCode } from "../../../../../WebExtension/src/utils/getActionCode";

export function getActionHUDContent(
  action: Action,
  i18n: Browser.I18n.Static
): HUDContent {
  const key = getActionCode(action);
  const getTitle = (code: string) => {
    return i18n.getMessage(`get_action_hud_content:${code}`);
  };
  switch (key) {
    case "tabClose":
      return { title: getTitle("tab_close"), icon: TabProhibited };
    case "tabCloseAll":
      return { title: getTitle("tab_close_all"), icon: Broom };
    case "tabOpen":
      return { title: getTitle("tab_open"), icon: TabAdd };
    case "tabDuplicate":
      return { title: getTitle("tab_duplicate"), icon: TabDesktopCopy };
    case "tabNext":
      return { title: getTitle("tab_next"), icon: ArrowCircleRight };
    case "tabPrevious":
      return { title: getTitle("tab_previous"), icon: ArrowCircleLeft };
    case "reload":
      return { title: getTitle("tab_reload"), icon: ArrowClockwise };
    case "javascriptRun": {
      const c: HUDContent = { title: getTitle("javascript_run"), icon: Code };
      if (action?.javascriptRun?.description) {
        c.message = action.javascriptRun.description;
      }
      return c;
    }
    case "urlCopy":
      return { title: getTitle("url_copy"), icon: ClipboardLink };
    case "scrollTop":
      return { title: getTitle("scroll_top"), icon: ArrowCurveUpLeft };
    case "scrollBottom":
      return { title: getTitle("scroll_bottom"), icon: ArrowCurveDownRight };
    case null:
      break;
    default:
      assertUnreachable(key);
  }
  return { title: getTitle("scroll_bottom") };
}
