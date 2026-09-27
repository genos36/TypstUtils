# Changelog
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