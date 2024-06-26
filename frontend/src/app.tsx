import { useRef } from 'preact/hooks'
import { fetchGreeting } from './clients/greetings';

export function App() {
  const greetingRef = useRef<HTMLDivElement>(null)
  const nameRef = useRef<HTMLInputElement>(null)

  const handleGreeting = async (event: Event) => {
    event.preventDefault();
    
    if (!greetingRef.current) return;
    if (!nameRef.current) return;

    const name = nameRef.current.value;
    greetingRef.current.textContent = await fetchGreeting(name);
  }

  return (
    <>
      <div>Klick auf den Button unten um gegrüßt zu werden!</div>
      <div ref={greetingRef} />

      <form onSubmit={handleGreeting}>
        <label>
          Dein Name <br/>
          <input ref={nameRef} type="text" />
        </label>

        <br/>
        <input type="submit" onClick={handleGreeting} value="Greets!" />
      </form>
    </>
  )
}
