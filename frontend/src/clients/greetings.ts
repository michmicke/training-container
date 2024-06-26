export async function fetchGreeting(name?: string) {
  if (!import.meta.env.VITE_API_BASE_URL) throw 'could not fetch greeting: base url not set';

  const payload: { name?: string } = {};
  if (name && name.length > 0) {
    payload.name = name;
  }

  const response = await fetch(
    `${import.meta.env.VITE_API_BASE_URL}/greeting`,
    {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload),
    },
  );

  const body = await response.json()
  return body.greeting
}
