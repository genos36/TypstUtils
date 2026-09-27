# TypstUtils

Raccolta personale di funzioni, template e show rule Typst per gli appunti
della laurea magistrale in Computer Science. Pensata per essere usata come
**package locale** (`@local`) da più repository di appunti.

> Richiede **Typst ≥ 0.15** (tipo `path`, PDF come immagini).

## Installazione

Il repo di sviluppo vive in una cartella qualsiasi; ogni versione rilasciata
viene esposta a Typst tramite `git worktree`:

```bash
git clone https://github.com/genos36/TypstUtils ~/proge
tti/TypstUtilscd ~/progetti/TypstUtils
# TESTATO ESCLUSIVAMENTE SU LINUX
./release.sh 0.1.0   # bump typst.toml, commit, tag, worktree
```

Le versioni finiscono in `~/.local/share/typst/packages/local/typst-utils/<versione>/`.

Su una nuova macchina, per ripristinare una versione già rilasciata:

```bash
git worktree add ~/.local/share/typst/packages/local/typst-utils/0.1.0 v0.1.0
```

## Uso rapido

```typ
#import "@local/typst-utils:0.1.0": *

#show: notes.with(
  course: [Computability],
  author: [Genos],
  year: [2026/27],
)

#let l03 = deck(file: path("slides/L03-turing.pdf"), name: "L03")

= Macchine di Turing
#definition[Una macchina di Turing è ...]
#slide-fig(deck: l03, 12) <sl:halting>
```

## Struttura

```
TypstUtils/
├── typst.toml
├── lib.typ            # entrypoint: re-esporta i moduli
├── release.sh
├── src/
│   ├── shared/        # strumenti indipendenti dallo stile
│   │   ├── custom-kinds.typ
│   │   ├── slides/
│   │   │   ├── mod.typ      # riesporta le funzioni pubbliche
│   │   │   ├── utils.typ    # controlli, didascalie, immagini
│   │   │   ├── deck.typ     # deck, slide-outline
│   │   │   ├── figure.typ   # slide-fig
│   │   │   ├── full.typ     # slide-full
│   │   │   └── side.typ     # slide-side
│   │   ├── notation.typ
│   │   └── markers.typ
│   └── notes/         # template per gli appunti
│       ├── template.typ
│       └── envs.typ
└── examples/
    └── demo.typ       # usa tutto: compilarlo = test di regressione
```

## Convenzioni per le funzioni

- **Argomenti nominali per default**, con un valore di default del tipo
  atteso (`name: ""`, `width: 100%`, `frame: true`). Quando non esiste un
  default sensato si usa `none` e un `assert` segnala che l'argomento è
  obbligatorio (es. `deck(file: ...)`).
- **Posizionali solo per il contenuto** (`body`), passato di norma come
  blocco finale: `kind-figure(kind: kinds.slide)[...]`.
- **Argomenti sink** (`..args`): la parte nominale si tratta come un
  dizionario, quella posizionale come un array
  (`l03(12, 13)` → pagine `(12, 13)`).
- **Due posizionali** solo nel caso "alla `align`": esattamente due
  posizionali e nessun altro argomento.
- **Kind custom** solo tramite il registro `kinds` in
  `src/shared/custom-kinds.typ`, con stringhe prefissate `tu-`.
- Gli argomenti obbligatori mancanti o del tipo sbagliato producono un
  `assert` con messaggio esplicito, nella forma `funzione: problema`.

## Moduli

### `shared/slides` — pagine dai PDF del docente

`deck(file:, name:, frame:, gap:)` dichiara un PDF (`file` come `path(...)`
o `bytes`) e restituisce un dizionario da passare ai layout come `deck:`.

| Layout | Uso |
|---|---|
| `slide-fig(deck:, ..pages, caption:, width:, columns:, frame:, gap:, label:)` | Figura nel testo; più pagine affiancate in griglia. |
| `slide-full(deck:, ..pages, caption:, columns:, flipped:, margin:, caption-space:, frame:, gap:, label:)` | Pagina dedicata, slide ridimensionate per riempirla (più pagine: dispensa). Solo a livello principale del documento. |
| `slide-side(deck:, page:, caption:, width:, side:, gap:, breakable:, frame:, label:)[testo]` | Una slide su un lato, il commento sull'altro; una chiamata per slide. |
| `slide-outline(title:)` | Indice delle sole slide citate. |

Didascalia automatica `"<name>, pp. 3–5"`; `frame` e `gap` a `auto`
ereditano dal deck. Le slide hanno numerazione separata dalle figure
normali. Con `slide-full` e `slide-side` la label va passata come
`label: <...>`, perché `<...>` dopo la chiamata finirebbe sul contenitore.

### `shared/notation` — notazioni comuni

Insiemi numerici, `bigO`, simboli di computabilità e logica, operatori
ricorrenti.

### `shared/markers` — marcatori di revisione

| Funzione | Uso |
|---|---|
| `todo[...]` | Da completare |
| `ask[...]` | Domanda da fare al docente |
| `exam[...]` | Argomento d'esame |
| `markers-outline(kind)` | Elenco di tutti i marcatori di un tipo |

### `notes/template` — template principale

`notes(course, author, year, lang: "it", body)`: pagina, font, numerazione
dei titoli, frontespizio e indice.

### `notes/envs` — ambienti

`definition`, `theorem`, `lemma`, `corollary`, `proof`, `example`, `remark`,
con numerazione condivisa per sezione.

## Dipendenze (da Typst Universe)

Da valutare, riesportate con stile uniforme:

- `curryst`: regole di inferenza (Hoare, sistemi di tipi)
- `fletcher`: automi e diagrammi
- `lovelace`: pseudocodice
- `codly`: blocchi di codice

## Controllo ortografico

Per i repository di appunti si usa **cspell** con dizionario italiano e
inglese e regole che ignorano codice, formule, label e riferimenti Typst.
Configurazione completa (`cspell.json`, `package.json`, `.gitignore`,
workflow GitHub) in [`docs/spell-check.md`](docs/spell-check.md).

```bash
npm install && npm run spell
```

## Roadmap

- [ ] 0.1.0: `slides`, `notes` template base, ambienti teorema
- [ ] 0.2.0: `markers` con indici
- [ ] 0.3.0: `notation`, integrazione `curryst` / `fletcher`
- [ ] Helper per matrici dei payoff (game theory)
- [x] `deck`: più pagine affiancate in una sola figura

## Versionamento

Semver semplificato: **patch** per correzioni senza impatto sull'output,
**minor** per aggiunte o modifiche dell'output/API. Ogni progetto di appunti
importa una versione fissa, così i documenti vecchi compilano sempre uguali.
Le modifiche sono registrate in `CHANGELOG.md`.
