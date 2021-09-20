import React from "react";
import ReactDOM from "react-dom";
import "./index.css";
import { CheckerApp } from "./CheckerApp";
import { check } from "./check";
import { ChakraProvider } from "@chakra-ui/react";

ReactDOM.render(
  <React.StrictMode>
    <ChakraProvider>
      <CheckerApp
        check={check}
        onOpenApp={() => window.open("svadilfari://")}
      />
    </ChakraProvider>
  </React.StrictMode>,
  document.getElementById("root")
);
