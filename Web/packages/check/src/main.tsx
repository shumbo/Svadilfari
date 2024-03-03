import { ChakraProvider } from "@chakra-ui/react";
import React from "react";
import { createRoot } from "react-dom/client";

import { check, checkBrowser } from "./check";
import { CheckerApp } from "./CheckerApp";
import { i18n } from "./i18n";
import "./index.css";

const isTouchDevice = "ontouchstart" in window || navigator.maxTouchPoints > 0;

i18n();
const container = document.getElementById("root");

if (container) {
  const root = createRoot(container);
  root.render(
    <React.StrictMode>
      <ChakraProvider>
        <CheckerApp
          check={check}
          onOpenApp={() => window.open("svadilfari://")}
          checkBrowser={() => {
            return checkBrowser(navigator.userAgent, isTouchDevice);
          }}
        />
      </ChakraProvider>
    </React.StrictMode>,
  );
}
