interface ContentMessanger {
  getUserConfig(): Promise<any>;
}

class ContentMessangerImpl implements ContentMessanger {
  getUserConfig(): Promise<any> {
    throw new Error("Method not implemented.");
  }
}
