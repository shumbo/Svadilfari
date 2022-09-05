import React from "react";
import { createRoot } from "react-dom/client";

import { ContentApp, ContentAppProps } from "./ContentApp";

export function setupContentApp(props: ContentAppProps): void {
  const root = document.createElement("div");
  root.id = "svadilfari-content-root";
  document.body.appendChild(root);

  // create shadow DOM and use it as a container
  const shadow = root.attachShadow({ mode: "open" });

  // create a style tag inside the shadow DOM
  const style = document.createElement("style");
  style.innerHTML = `@import "${browser.runtime.getURL("content.css")}";`;
  shadow.appendChild(style);

  const app = document.createElement("div");
  shadow.appendChild(app);

  createRoot(app).render(<ContentApp {...props} />);
}
