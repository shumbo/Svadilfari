import { Global, css } from "@emotion/react";
import React, { FC } from "react";

const styles = css`
  body {
    width: min(${window.screen.width}px, 400px);
    margin: 0 auto;
  }
`;

export const PopupGlobalStyle: FC = () => {
  return <Global styles={styles} />;
};
