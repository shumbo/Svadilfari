import { setTranslations, setLocale } from "react-i18nify";

export function i18n(): void {
  setTranslations({
    en: {
      check_result: {
        check_in_progress: "Check in progress...",
        app_link: "Open Svadilfari",
        active: {
          title: "Svadilfari is Active!",
          description: "Gestures should work now!",
        },
        inactive: {
          title: "Svadilfari is NOT Active!",
          description: "Follow the tutorial to activate the extension",
        },
      },
    },
    ja: {
      check_result: {
        check_in_progress: "チェックしています...",
        app_link: "Svadilfariを開く",
        active: {
          title: "Svadilfariは有効です!",
          description: "ジェスチャーを試してみましょう!",
        },
        inactive: {
          title: "Svadilfariが有効化されていません!",
          description: "チュートリアルを完了して機能拡張を有効化してください",
        },
      },
    },
  });
  setLocale(navigator.language);
}
