import React from "react";
import ReactDOM from "react-dom";
import { ContentApp } from "./ContentApp";

export function setupContentApp() {
  const root = document.createElement("div");
  document.body.appendChild(root);

  ReactDOM.render(<ContentApp />, root);
}
