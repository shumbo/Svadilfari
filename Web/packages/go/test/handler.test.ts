import { handleRequest } from '../src/handler'
import makeServiceWorkerEnv from 'service-worker-mock'

declare var global: any

describe('handle', () => {
  beforeEach(() => {
    Object.assign(global, makeServiceWorkerEnv())
    jest.resetModules()
  })

  test('handle GET JA', async () => {
    const result = await handleRequest(
      new Request('/privacy-policy', {
        method: 'GET',
        headers: { 'accept-language': 'ja' },
      }),
    )
    expect(result.status).toEqual(301)
    expect(result.headers.get('Location')).toBe(
      'https://www.svadilfari.app/ja/privacy-policy',
    )
  })
  test('handle GET ja-jp', async () => {
    const result = await handleRequest(
      new Request('/privacy-policy', {
        method: 'GET',
        headers: { 'Accept-Language': 'ja-jp' },
      }),
    )
    expect(result.status).toEqual(301)
    expect(result.headers.get('Location')).toBe(
      'https://www.svadilfari.app/ja/privacy-policy',
    )
  })
  test('handle GET EN', async () => {
    const result = await handleRequest(
      new Request('/privacy-policy', {
        method: 'GET',
        headers: { 'accept-language': 'en' },
      }),
    )
    expect(result.status).toEqual(301)
    expect(result.headers.get('Location')).toBe(
      'https://www.svadilfari.app/privacy-policy',
    )
  })
  test('handle GET No Specified Language', async () => {
    const result = await handleRequest(
      new Request('/privacy-policy', {
        method: 'GET',
      }),
    )
    expect(result.status).toEqual(301)
    expect(result.headers.get('Location')).toBe(
      'https://www.svadilfari.app/privacy-policy',
    )
  })
})
