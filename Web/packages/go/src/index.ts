import { handleRequest } from "./handler";

export default {
  fetch(request) {
    return handleRequest(request);
  },
} satisfies ExportedHandler;
