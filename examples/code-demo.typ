#import "/lib.typ": *

#show: notes.with(meta: (title: [Functional Languages], year: [A.A. 2026/27]))

#preface(outlines: ("heading", raw, "todo", "ask"))[]

= Codice
Vedi @lst:fact e @lst:map. Il codice inline `map f xs` non è toccato da codly.

#code-fig(caption: [Fattoriale in Haskell])[```haskell
fact :: Integer -> Integer
fact 0 = 1
fact n = n * fact (n - 1)
```] <lst:fact>

#todo[Aggiungere la versione tail-recursive]

#codly(highlights: ((line: 2, start: 5, end: none, fill: red),))
#code-fig(caption: [Map in Python], label: <lst:map>)[```python
def my_map(f, xs):
    return [f(x) for x in xs]
```]

#ask(detail: [Nelle slide L04 sembra di sì, ma l'esempio a p. 12 dice il contrario.])[
  La valutazione lazy vale anche per gli argomenti dei costruttori?
]

Blocco senza figura, con righe selezionate:
#codly-range(2, end: 3)
```rust
fn main() {
    let x = 5;
    println!("{x}");
}
```

#no-codly[```
testo semplice senza codly
```]

#code-fig(caption: [Lungo])[#raw(range(1, 80).map(i => "print(" + str(i) + ")").join("\n"), lang: "python", block: true)]

#todo[Rivedere il paragrafo]
