export function check(): boolean {
  return !!document.getElementById("svadilfari-content-root");
}

export function checkBrowser(ua: string, isTouchDevice: boolean): boolean {
  if (!isTouchDevice) {
    return false;
  }
  const iphoneRegex =
    /Mozilla\/5\.0 \(iPhone; CPU iPhone OS [\d_]+ like Mac OS X\) AppleWebKit\/[\d\.]+ \(KHTML, like Gecko\) Version\/[\d\.]+ Mobile\/[\dA-Z]+ Safari\/[\d\.]+/;

  const ipadRegex =
    /Mozilla\/5\.0 \(Macintosh; Intel Mac OS X [\d_]+\) AppleWebKit\/[\d\.]+ \(KHTML, like Gecko\) Chrome\/[\d\.]+ Safari\/[\d\.]+/;
  if (iphoneRegex.test(ua) || ipadRegex.test(ua)) {
    return true;
  }

  return false;
}
