# Changelog
## [0.5.0]
 
- `strings`: `to-kebab`, `to-snake`, `to-camel`, `to-pascal` per chiavi,
  label e nomi; `words` (divisione in parole, anche camelCase) e
  `to-string` (testo da content semplice). Opzione `ascii` per togliere
  gli accenti.

## [0.4.0]
 
- `packages.typ`: dipendenze esterne centralizzate (codly 1.3.0,
  codly-languages 0.1.10).
- `rule-code`: blocchi di codice con codly (linguaggi, righe alternate,
  font opzionale, figure di codice spezzabili, `options` passate a codly);
  incluso nel preset `notes`.
- `code-fig(caption:, label:)[...]`: codice come figura numerata.
- Funzioni di codly riesportate (`codly`, `codly-local`, `no-codly`,
  `codly-range`, `codly-offset`, `codly-skip`, `codly-enable`,
  `codly-disable`), così i progetti non importano codly da sé.
- `markers`: `todo` e `ask` (più `marker` generico), con testo breve per
  gli indici e `detail` facoltativo; kind `todo` e `ask` nel registro.
- `rule-markers`: aspetto dei marcatori, `visible: false` per nasconderli;
  incluso nel preset `notes`.
- `make-outline`: titoli di default anche per `image`, `table`, `raw`.

## [0.3.0]
 
- `box`: riquadri visivi `callout` e preset `note`, `tip`, `warning`,
  `question`.
- `envs`: `theorem`, `lemma`, `corollary`, `proposition` (numerazione
  condivisa), `definition`, `example` come figure con kind del registro;
  `proof` non numerata con ∎; `env` generico.
- `rule-envs`: aspetto degli ambienti, incluso nel preset `notes`.
- `custom-kinds`: kind `thm`, `definition`, `example`; campo `outline` con il
  titolo di default dell'indice; `kind-figure` accetta un `supplement`
  che sostituisce quello del registro.
- `preface(outlines:)[...]`: parte introduttiva con numerazione separata,
  poi ripartenza da 1; `title-page(meta:)`; `make-outline(spec:)`
  polimorfico (stringa, tipo, dizionario, content).
- `rule-refs`: stile applicato anche ai riferimenti agli ambienti.
- `compose`: controlli sui tipi di `preset`, `rules`, `extra`.




## [0.2.1]
fixed stuff


## [0.2.0]
 
- `rules`: regole componibili `rule-page`, `rule-text`, `rule-lists`,
  `rule-raw`, `rule-tables`, `rule-figures`, `rule-links`, `rule-refs`,
  `rule-headings`, con stili condivisi (`style-internal-ref`,
  `style-external-link`).
- `compose`: applica un preset di regole; modifiche per nome (argomenti,
  sostituzione, disattivazione) e regole `extra` con precedenza.
- `notes`: template per gli appunti basato su `notes-preset`.
- Import interni con percorsi assoluti dalla root del package (`/src/...`).
- `three-slots`: riga a tre posizioni (sinistra, centro, destra).
- `rule-header`, `rule-footer`, `page-num`.
- `meta`: dati del documento con default e controllo dei campi.
- `notes` accetta `meta`: metadati del PDF, lingua di testo e capitoli,
  intestazione; `notes-preset` diventa una funzione di `meta`.
- `rule-headings`: la lingua del supplemento è il parametro `lang`
  (niente più context).

## [0.1.0]

Prima versione.

- `custom-kinds`: registro centrale dei kind custom (`kinds`), con
  `kind-figure` e `kind-selector`; prefisso `course-`.
- `slides`: `deck` per dichiarare un PDF di slide e tre layout:
  `slide-fig` (nel testo, più pagine in griglia), `slide-full` (pagina
  dedicata, anche a dispensa), `slide-side` (slide affiancata al testo).
- `slide-outline`: indice delle slide citate.