function website(path: string) {
  return `https://www.svadilfari.app${path}`
}

const redirects = new Map([
  ['privacy-policy', website('/privacy-policy')],
  ['checker', 'https://check.svadilfari.app'],
])

export async function handleRequest(request: Request): Promise<Response> {
  const pathname = new URL(request.url).pathname.replace('/', '')
  const location = redirects.get(pathname)
  return location
    ? Response.redirect(location, 301)
    : new Response('Not Found', { status: 404 })
}
