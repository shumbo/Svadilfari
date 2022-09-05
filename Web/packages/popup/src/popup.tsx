import { ChakraProvider, extendTheme } from "@chakra-ui/react";
import React from "react";
import { createRoot } from "react-dom/client";

import { PopupApp } from "./PopupApp";
import { PopupMessengerImpl } from "./PopupMessenger";
import { PopupTabManagerImpl } from "./PopupTabManager";

const container = document.getElementById("root");
if (container) {
  const root = createRoot(container);
  root.render(
    <ChakraProvider
      theme={extendTheme({
        config: { initialColorMode: "light", useSystemColorMode: true },
      })}
    >
      <PopupApp
        i18n={browser.i18n}
        messenger={new PopupMessengerImpl()}
        tabManager={new PopupTabManagerImpl()}
      />
    </ChakraProvider>
  );
}
