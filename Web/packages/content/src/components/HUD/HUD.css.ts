import { style } from "@vanilla-extract/css";

export const animationContainerStyle = style({
  position: "fixed",
  top: 0,
  left: 0,
  right: 0,
  bottom: 0,
  display: "flex",
  alignItems: "center",
  justifyContent: "center",
  zIndex: 2147483647,
});

export const wrapperStyle = style({
  width: 250,
  height: 250,
  backdropFilter: "blur(3px)",
  WebkitBackdropFilter: "blur(3px)",
  borderRadius: 8,
  display: "flex",
  flexDirection: "column",
  alignItems: "center",
  justifyContent: "center",

  backgroundColor: "rgba(255, 255, 255, 0.8)",
  "@media": {
    "prefers-color-scheme: dark": {
      backgroundColor: "rgba(0, 0, 0, 0.8)",
    },
  },
});

export const iconWrapperStyle = style({
  fill: "#636366ff",
  "@media": {
    "prefers-color-scheme: dark": {
      fill: "#aeaeb2ff",
    },
  },
});

export const textStyle = style({
  textAlign: "center",
  margin: 0,
  fontFamily: "-apple-system",
  color: "#636366ff",
  "@media": {
    "prefers-color-scheme: dark": {
      color: "#aeaeb2ff",
    },
  },
});

export const titleStyle = style([
  textStyle,
  {
    fontSize: "24px",
  },
]);
