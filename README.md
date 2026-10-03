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
│   ├── packages.typ         # dipendenze esterne: versioni solo qui
│   ├── shared/              # strumenti indipendenti dal tipo di documento
│   │   ├── custom-kinds.typ # registro dei kind custom
│   │   ├── slots.typ        # three-slots: sinistra / centro / destra
│   │   ├── strings.typ      # to-kebab, to-snake, to-camel, to-pascal
│   │   ├── meta.typ         # dati del documento (default e controlli)
│   │   ├── box.typ          # riquadri visivi (callout)
│   │   ├── envs.typ         # teoremi, definizioni, esempi, dimostrazioni
│   │   ├── markers.typ      # todo, domande per il docente
│   │   ├── code.typ         # code-fig, funzioni di codly riesportate
│   │   ├── preface/
│   │   │   ├── mod.typ
│   │   │   ├── preface.typ     # preface
│   │   │   ├── title-page.typ  # copertina
│   │   │   └── outlines.typ    # make-outline polimorfico
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
│   │       ├── page.typ     text.typ     lists.typ    terms.typ    raw.typ
│   │       ├── tables.typ   figures.typ  links.typ    refs.typ
│   │       ├── headings.typ
│   │       ├── header.typ   footer.typ
│   │       ├── envs.typ     # aspetto degli ambienti
│   │       ├── markers.typ  # aspetto dei marcatori
│   │       └── code.typ     # codly
│   └── notes/               # appunti
│       ├── mod.typ
│       ├── preset.typ       # regole e valori scelti per gli appunti
│       └── template.typ     # notes(rules:, extra:)
└── examples/
    ├── demo.typ             # slide
    ├── notes-demo.typ       # template e regole
    ├── envs-demo.typ        # copertina, indici, ambienti, riquadri
    ├── code-demo.typ        # codice e marcatori
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
- **Funzioni pure su un singolo valore** (conversioni di stringhe) hanno
  il valore posizionale, come `lower` e `upper` di Typst:
  `to-kebab("...")`; le opzioni restano nominali.
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
 
### `shared/strings` — conversioni di stringhe
 
`to-kebab`, `to-snake`, `to-camel`, `to-pascal`: accettano stringhe o
content semplice (testo, spazi, enfasi) e l'opzione `ascii` per togliere
gli accenti. Utili per chiavi di dizionari e label generate dal testo.
 
```typ
#to-kebab([Teorema di *Rice*])                   // "teorema-di-rice"
#to-camel("macchina_di-turing")                  // "macchinaDiTuring"
#to-kebab("Riducibilità e Rice", ascii: true)    // "riducibilita-e-rice"
```
 
Si basano su `words` (divide in parole minuscole, riconoscendo spazi,
punteggiatura e confini camelCase) e `to-string` (testo da content).
 
### `shared/meta` — dati del documento
 
Dati passati esplicitamente, senza context. Campi (`default-meta`):
`title`, `author` (stringa o array di stringhe), `date` (datetime), `lang`,
`teacher`, `year`, `degree`. Un campo sconosciuto produce un errore.
 
### `shared/box` — riquadri visivi
 
`callout(title:, color:, fill-lighten:, breakable:)[...]` e i preset
`note`, `tip`, `warning`, `question` (titolo sovrascrivibile). Non numerati
né referenziabili.
 
### `shared/envs` — ambienti
 
Figure con kind del registro, quindi numerate, referenziabili e
indicizzabili. `theorem`, `lemma`, `corollary`, `proposition` condividono la
numerazione (kind `thm`); `definition` ed `example` hanno la propria.
Argomenti: `title` (tra parentesi nel titolo) e `supplement` (nome, es. per
un'altra lingua: `theorem.with(supplement: [Theorem])`). `proof(title:,
qed:)` non è numerata. L'aspetto lo dà `rule-envs`; senza, gli ambienti
appaiono come figure standard.
 
### `shared/markers` — marcatori di revisione
 
`todo(detail:)[testo breve]` e `ask(detail:)[domanda]`: figure con kind del
registro, quindi numerate e raccolte negli indici (`"todo"`, `"ask"` in
`preface` o `make-outline`). Il testo breve compare nell'indice, `detail`
solo nel testo. L'aspetto lo dà `rule-markers` (`visible: false` li
nasconde, es. per una versione da condividere). Diversamente da
`question` (box), `ask` è numerata e indicizzata.
 
### `shared/code` — codice
 
`code-fig(caption:, label:)[```lang ...```]`: codice come figura numerata.
Le funzioni di codly sono riesportate (`codly`, `codly-local`, `no-codly`,
`codly-range`, `codly-offset`, `codly-skip`, `codly-enable`,
`codly-disable`): il progetto non importa codly direttamente, così la
versione resta quella di `src/packages.typ`.
 
### `shared/preface` — parte introduttiva
 
`preface(outlines:, numbering:)[contenuto]`: contenuto iniziale e indici
con numerazione a parte (default romana), poi la numerazione riparte da 1.
`title-page(meta:, subtitle:, date-format:, extra:)`: copertina senza
intestazione né numero. `make-outline(spec:)` accetta:
 
| Spec | Significato |
|---|---|
| stringa | `"heading"`, un nome del registro (`"thm"`, `"slide"`...) con il titolo di indice del registro, o una stringa di kind qualsiasi |
| tipo | `heading`, `image`, `table`, `raw` |
| dizionario | `kind` → `target`, il resto va a `outline` |
| content | un `outline(...)` già costruito |
 
```typ
#preface(outlines: ("heading", "thm", (kind: "slide", depth: 1)))[
  #title-page(meta: meta, subtitle: [Appunti del corso])
]
```
 
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
| `rule-terms` | `term-style` (funzione, default `emph`; none = grassetto), `separator`, `indent`, `hanging-indent`, `strong-delta` |
| `rule-raw` | `size` |
| `rule-tables` | `inset`, `zebra`, `breakable`, `keep-cells` |
| `rule-figures` | `kinds`, `spacing` |
| `rule-links` | `external`, `internal` (funzioni di stile) |
| `rule-refs` | `kinds`, `headings`, `style` |
| `rule-headings` | `numbering`, `above`, `below`, `chapter-break`, `chapter-style`, `supplement`, `lang` |
| `rule-header` | `left`, `center`, `right`, `size`, `line`, `gap` |
| `rule-footer` | `left`, `center`, `right`, `size`, `line`, `gap` |
| `rule-envs` | `colors` (per voce del registro), `spacing` |
| `rule-markers` | `colors` (per voce del registro), `visible` |
| `rule-missing-refs` | `placeholder` (funzione); solo per compilare un capitolo da solo, non nel preset |
| `rule-code` | `languages`, `zebra-fill`, `font`, `breakable`, `options` (passate a codly) |
 
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
 
## Appunti su più file
 
Ogni capitolo è compilabile da solo e il documento completo li riunisce con
una sola bibliografia (e, allo stesso modo, un solo glossario o indice).
Si sfrutta il fatto che **importare un file ne ignora il contenuto
visibile**: solo i binding (`#let`) vengono importati. È l'equivalente di
`if __name__ == "__main__"`.
 
```typ
// chapters/turing.typ
#import "../common.typ": *
#let body = [
  = Macchine di Turing <cap:turing>
  ...
]
// Solo se questo file è l'entrypoint:
#show: chapter-notes        // notes + rule-missing-refs
#body
#course-bib()
 
// main.typ
#import "chapters/turing.typ" as turing
#show: course-notes
#turing.body
#course-bib()
```
 
Nel capitolo singolo i riferimenti ad altri capitoli (`@cap:rice`)
diventano segnaposto grazie a `rule-missing-refs`; nel documento completo
restano riferimenti veri. Esempio completo in `examples/multi/`.
 
## Dipendenze (da Typst Universe)
 
Le versioni sono definite solo in `src/packages.typ`; al momento: `codly`,
`codly-languages`. Da valutare, riesportate con stile uniforme:
 
- `curryst`: regole di inferenza (Hoare, sistemi di tipi)
- `fletcher`: automi e diagrammi
- `lovelace`: pseudocodice
## Controllo ortografico
 
Per i repository di appunti si usa **cspell** con dizionario italiano e
inglese e regole che ignorano codice, formule, label e riferimenti Typst.
Configurazione completa (`cspell.json`, `package.json`, `.gitignore`,
workflow GitHub) in [`docs/spell-check.md`](docs/spell-check.md).
 
```bash
npm install && npm run spell
```
 
## Roadmap
 
- [x] **0.1.0**: `custom-kinds`; `slides` (`deck`, `slide-fig`,
  `slide-full`, `slide-side`, `slide-outline`)
- [x] **0.2.0**: regole componibili, `compose`, preset e template `notes`;
  `three-slots`, header e footer, `page-num`, `meta`
- [ ] **0.3.0**: `box`, `envs` con `rule-envs`, `preface`, `title-page`,
  `make-outline`
- [ ] **0.4.0**: `markers` (`todo`, `ask`) con `rule-markers`; codly con
  `rule-code`, `code-fig` e funzioni riesportate; `packages.typ`
- [ ] **0.5.0**: `strings` (`to-kebab`, `to-snake`, `to-camel`,
  `to-pascal`, `words`, `to-string`)
- [ ] Da valutare
  - `current-chapter` per l'intestazione (context, opt-in)
  - numerazione degli ambienti per capitolo (es. Teorema 2.3)
  - notazioni matematiche comuni, eventualmente come regola
  - altri marcatori (es. argomenti d'esame)
  - `code-file`: codice incluso da file, con linguaggio dall'estensione
  - regola per parole composte non spezzabili
  - facade `slide(deck:, mode: ...)` dopo l'uso reale dei tre layout
  - integrazione `curryst`, `fletcher`, `lovelace`, `codly`
  - helper per matrici dei payoff
## Contribuire
 
Architettura, scelte di design, ambiente di sviluppo e flusso di lavoro sono
descritti in [CONTRIBUTING.md](CONTRIBUTING.md).
 
## Versionamento
 
Semver semplificato: **patch** per correzioni senza impatto sull'output,
**minor** per aggiunte o modifiche dell'output/API. Ogni progetto di appunti
importa una versione fissa, così i documenti vecchi compilano sempre uguali.
Le modifiche sono registrate in `CHANGELOG.md`.
