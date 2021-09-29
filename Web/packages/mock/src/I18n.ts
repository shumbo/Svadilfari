/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable @typescript-eslint/explicit-module-boundary-types */

import { Browser } from "webextension-typedef";
import en from "../../../../SvadilfariExtension/Resources/_locales/en/messages.json";

export class MockI18n implements Browser.I18n.Static {
  getAcceptLanguages(): Promise<string[]> {
    throw new Error("Method not implemented.");
  }
  getMessage(messageName: string, _substitutions?: any): string {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    return (en as any)[messageName] ? (en as any)[messageName]["message"] : "";
  }
  getUILanguage(): string {
    throw new Error("Method not implemented.");
  }
  detectLanguage(
    _text: string
  ): Promise<Browser.I18n.DetectLanguageCallbackResultType> {
    throw new Error("Method not implemented.");
  }
}
