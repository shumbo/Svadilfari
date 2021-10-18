import acceptLanguage from 'accept-language'
acceptLanguage.languages(['en-US', 'ja', 'ja-JP'])

function website(acceptLanguageValue: string | null, path: string) {
  const l = acceptLanguage.get(acceptLanguageValue)
  if (l === 'ja-JP' || l === 'ja') {
    return `https://www.svadilfari.app/ja${path}`
  }
  return `https://www.svadilfari.app${path}`
}

export async function handleRequest(request: Request): Promise<Response> {
  const acceptLanguageValue = request.headers.get('Accept-Language')
  const redirects = new Map([
    ['about', website(acceptLanguageValue, '/docs/about')],
    ['privacy-policy', website(acceptLanguageValue, '/privacy-policy')],
    ['faq', website(acceptLanguageValue, '/docs/faq')],
    ['contact', website(acceptLanguageValue, '/contact')],
    ['checker', 'https://check.svadilfari.app'],
  ])
  const pathname = new URL(request.url).pathname.replace('/', '')
  const location = redirects.get(pathname)
  return location
    ? Response.redirect(location, 301)
    : new Response('Not Found', { status: 404 })
}
