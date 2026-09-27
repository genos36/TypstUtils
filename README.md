# TypstUtils

Raccolta personale di funzioni, template e show rule Typst per gli appunti
della laurea magistrale in Computer Science. Pensata per essere usata come
**package locale** (`@local`) da più repository di appunti.

> Richiede **Typst ≥ 0.15** (tipo `path`, PDF come immagini).

## Installazione

Il repo di sviluppo vive in una cartella qualsiasi; ogni versione rilasciata
viene esposta a Typst tramite `git worktree`:

```bash
git clone https://github.com/genos36/TypstUtils ~/progetti/TypstUtils
cd ~/progetti/TypstUtils
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
#import "@local/typst-utils:0.2.0": *
 
// common.typ del progetto: dati e template configurati una volta
#let meta = (title: [Computability], author: "Genos", year: [A.A. 2026/27])
#let course-notes = notes.with(
  meta: meta,
  rules: (page: (margin: 2cm)),              // cambia un argomento del preset
  extra: (body => { set text(size: 10.5pt); body },),  // regola del progetto
)
 
// main.typ
#show: course-notes
 
#let l03 = deck(file: path("slides/L03-turing.pdf"), name: "L03")
 
= Macchine di Turing
#slide-fig(deck: l03, 12) <sl:halting>
#slide-side(deck: l03, page: 13)[Commento alla slide.]
```
 
## Struttura
 
```
TypstUtils/
├── typst.toml
├── lib.typ                  # entrypoint: riesporta i moduli
├── release.sh               # rilascio (testato solo su Linux)
├── CHANGELOG.md
├── docs/
│   └── spell-check.md       # configurazione cspell per i repo di appunti
├── src/
│   ├── shared/              # strumenti indipendenti dal tipo di documento
│   │   ├── custom-kinds.typ # registro dei kind custom
│   │   ├── slots.typ        # three-slots: sinistra / centro / destra
│   │   ├── meta.typ         # dati del documento (default e controlli)
│   │   ├── slides/
│   │   │   ├── mod.typ      # riesporta le funzioni pubbliche
│   │   │   ├── utils.typ    # controlli, didascalie, immagini (interne)
│   │   │   ├── deck.typ     # deck, slide-outline
│   │   │   ├── figure.typ   # slide-fig
│   │   │   ├── full.typ     # slide-full
│   │   │   └── side.typ     # slide-side
│   │   └── rules/
│   │       ├── mod.typ      # riesporta regole, stili e compose
│   │       ├── compose.typ  # applica un preset con modifiche
│   │       ├── styles.typ   # stili di link e riferimenti
│   │       ├── page.typ     text.typ     lists.typ    raw.typ
│   │       ├── tables.typ   figures.typ  links.typ    refs.typ
│   │       ├── headings.typ
│   │       └── header.typ   footer.typ
│   └── notes/               # appunti
│       ├── mod.typ
│       ├── preset.typ       # regole e valori scelti per gli appunti
│       └── template.typ     # notes(rules:, extra:)
└── examples/
    ├── demo.typ             # slide
    ├── notes-demo.typ       # template e regole
    └── slides/L03.pdf       # PDF di prova
```
 
Le demo si compilano dalla root del repo con `--root .`, es.
`typst compile --root . examples/notes-demo.typ`: compilarle è il test di
regressione.
 
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
- **`context` solo dove inevitabile** (misure, contatori di pagina, query).
  Rallenta la compilazione e rende il flusso dei dati meno tracciabile: si
  preferisce passare i valori come argomenti. Le funzioni che lo usano lo
  dichiarano nella documentazione.
- Gli argomenti obbligatori mancanti o del tipo sbagliato producono un
  `assert` con messaggio esplicito, nella forma `funzione: problema`.
## Moduli
 
### `shared/custom-kinds` — registro dei kind
 
`kinds` contiene i kind custom (stringhe con prefisso `course-` e
supplemento). `kind-figure(kind:, ..args)[contenuto]` crea una figura di un
kind, `kind-selector(kind:)` il selettore per outline e show rule.
 
### `shared/slots` — tre posizioni
 
`three-slots(left:, center:, right:)`: riga con contenuto a sinistra, al
centro e a destra; il centro resta centrato anche con lati di lunghezza
diversa. Base di header e footer, riusabile altrove.
 
### `shared/meta` — dati del documento
 
Dati passati esplicitamente, senza context. Campi (`default-meta`):
`title`, `author` (stringa o array di stringhe), `date` (datetime), `lang`,
`teacher`, `year`, `degree`. Un campo sconosciuto produce un errore.
 
### `shared/slides` — pagine dai PDF del docente
 
`deck(file:, name:, frame:, gap:)` dichiara un PDF (`file` come `path(...)`
o `bytes`) e restituisce un dizionario da passare ai layout come `deck:`.
 
| Layout | Uso |
|---|---|
| `slide-fig(deck:, ..pages, caption:, width:, columns:, frame:, gap:, label:)` | Figura nel testo; più pagine affiancate in griglia. |
| `slide-full(deck:, ..pages, caption:, columns:, flipped:, margin:, caption-space:, frame:, gap:, label:)` | Pagina dedicata, slide ridimensionate per riempirla (più pagine: dispensa). Solo a livello principale del documento. Usa context. |
| `slide-side(deck:, page:, caption:, width:, side:, gap:, breakable:, frame:, label:)[testo]` | Una slide su un lato, il commento sull'altro; una chiamata per slide. |
| `slide-outline(title:)` | Indice delle sole slide citate. |
 
Didascalia automatica `"<name>, pp. 3–5"`; `frame` e `gap` a `auto`
ereditano dal deck. Le slide hanno numerazione separata dalle figure
normali. Con `slide-full` e `slide-side` la label va passata come
`label: <...>`, perché `<...>` dopo la chiamata finirebbe sul contenitore.
 
### `shared/rules` — regole componibili
 
Ogni regola è una factory con argomenti nominali che restituisce una
funzione `body => ...`, usabile anche da sola (`#show: rule-lists()`).
 
| Regola | Argomenti |
|---|---|
| `rule-page` | `paper`, `margin`, `numbering`, `number-align` |
| `rule-text` | `font`, `size`, `lang`, `leading`, `spacing`, `justify` |
| `rule-lists` | `markers` |
| `rule-raw` | `size` |
| `rule-tables` | `inset`, `zebra`, `breakable`, `keep-cells` |
| `rule-figures` | `kinds`, `spacing` |
| `rule-links` | `external`, `internal` (funzioni di stile) |
| `rule-refs` | `kinds`, `headings`, `style` |
| `rule-headings` | `numbering`, `above`, `below`, `chapter-break`, `chapter-style`, `supplement`, `lang` |
| `rule-header` | `left`, `center`, `right`, `size`, `line`, `gap` |
| `rule-footer` | `left`, `center`, `right`, `size`, `line`, `gap` |
 
Header e footer senza contenuto non modificano la pagina. Un footer
personalizzato sostituisce la numerazione standard: il numero va inserito
con `page-num(numbering:)` (usa context), es. `right: page-num(numbering: "1 / 1")`.
 
`compose(preset:, rules:, extra:)[body]` applica un preset
(`nome: (rule: factory, args: (..))`). In `rules`, per nome: un dizionario
modifica solo quegli argomenti, una funzione sostituisce la regola, `none`
la disattiva. Le `extra` sono applicate per ultime e hanno la precedenza.
 
### `notes` — template per gli appunti
 
`notes(meta:, rules:, extra:)` applica `notes-preset(meta:)` tramite
`compose`. `meta` imposta i metadati del PDF (`set document`), la lingua di
testo e capitoli, e l'intestazione (corso a sinistra, anno a destra). Il
footer di default è la numerazione standard. Nel progetto si configura una
volta con `notes.with(meta: ..., rules: ...)`.
 
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
 
- [x] **0.1.0**: `custom-kinds` (registro dei kind); `slides` con `deck`,
  `slide-fig`, `slide-full`, `slide-side`, `slide-outline`
- [ ] **0.2.0**: regole componibili (`page`, `text`, `lists`, `raw`,
  `tables`, `figures`, `links`, `refs`, `headings`), `compose`, preset e
  template `notes`
- [ ] **0.3.0**: header e footer
  - [x] `three-slots` (sinistra / centro / destra) come infrastruttura generica
  - [x] `rule-header`, `rule-footer`; nel preset `notes` intestazione da
    `meta` e numerazione standard
  - [x] dati del documento passati esplicitamente (`meta`), senza context
  - [x] `page-num` (context, opt-in)
  - [ ] `current-chapter` (context, opt-in)
- [ ] **0.4.0**: parte introduttiva
  - `preface(outlines: ...)[copertina]`: pagine in numeri romani, poi
    ripartenza da 1
  - `title-page(...)` componibile, dati da `meta`
  - outline polimorfico: stringa (kind, risolto tramite `kinds`), tipo
    built-in, dizionario (`kind` → `target` + spreading), content
- [ ] **0.5.0**: ambienti e notazioni
  - `box`: riquadri visivi non numerati (nota, attenzione, domanda)
  - `envs`: definizione, teorema, lemma, corollario, esempio (kind nel
    registro, numerati e referenziabili) e dimostrazione (∎)
  - `math`: notazioni comuni (insiemi, `bigO`, computabilità, logica)
- [ ] Da valutare
  - `markers` (todo, domande, argomenti d'esame) con indici
  - regola per parole composte non spezzabili
  - facade `slide(deck:, mode: ...)` dopo l'uso reale dei tre layout
  - integrazione `curryst`, `fletcher`, `lovelace`, `codly`
  - helper per matrici dei payoff
## Versionamento
 
Semver semplificato: **patch** per correzioni senza impatto sull'output,
**minor** per aggiunte o modifiche dell'output/API. Ogni progetto di appunti
importa una versione fissa, così i documenti vecchi compilano sempre uguali.
Le modifiche sono registrate in `CHANGELOG.md`.
