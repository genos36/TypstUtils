# Controllo ortografico con cspell

Guida per configurare [cspell](https://cspell.org) in un repository di appunti
Typst, con dizionario italiano + inglese e regole per ignorare codice, formule
e riferimenti. Lo scopo è trovare la maggior parte dei typo, non fare una
revisione grammaticale completa.

## File da aggiungere al repo di appunti

```
repo-appunti/
├── cspell.json          # configurazione
├── project-words.txt    # parole accettate (termini tecnici, nomi)
├── package.json         # dipendenze npm (cspell + dizionario italiano)
└── .gitignore           # esclude node_modules
```

Si committano tutti tranne `node_modules/`.

## 1. Dipendenze

Il dizionario italiano non è incluso in cspell, va installato come pacchetto
npm. Tenerlo in `package.json` rende il repo autosufficiente:

```json
{
  "private": true,
  "scripts": {
    "spell": "cspell --no-progress \"**/*.typ\""
  },
  "devDependencies": {
    "cspell": "^9",
    "@cspell/dict-it-it": "^3"
  }
}
```

```bash
npm install
```

> Le versioni sono indicative: controlla le ultime con `npm view cspell version`
> e `npm view @cspell/dict-it-it version`.

## 2. `.gitignore`

```gitignore
node_modules/
*.pdf
```

Escludere `*.pdf` evita di committare gli output compilati. Se invece tieni
nel repo i PDF delle slide del docente, limita la regola alla cartella di
output (ad esempio `out/*.pdf`).

## 3. `cspell.json`

```json
{
  "version": "0.2",
  "language": "it,en",
  "import": ["@cspell/dict-it-it/cspell-ext.json"],
  "enableFiletypes": ["typst"],
  "dictionaryDefinitions": [
    {
      "name": "project-words",
      "path": "./project-words.txt",
      "addWords": true
    }
  ],
  "dictionaries": ["project-words"],
  "ignorePaths": ["node_modules/**", ".git/**", "*.pdf", "package-lock.json"],
  "overrides": [
    {
      "filename": "**/*.typ",
      "ignoreRegExpList": [
        "/```[\\s\\S]*?```/g",
        "/`[^`\\n]*`/g",
        "/(?<!\\\\)\\$[\\s\\S]*?(?<!\\\\)\\$/g",
        "/#import.*$/gm",
        "/#[\\w.-]+/g",
        "/<[\\w:.-]+>/g",
        "/@[\\w:.-]+/g",
        "/\"[^\"\\n]*\"/g"
      ]
    }
  ]
}
```

Cosa ignorano le regole, nell'ordine:

| Regex | Ignora |
|---|---|
| ```` ``` ... ``` ```` | blocchi di codice |
| `` `...` `` | codice inline |
| `$ ... $` | formule matematiche (anche su più righe) |
| `#import ...` | righe di import |
| `#nome` | nomi di funzioni e variabili Typst |
| `<label>` | label |
| `@ref` | riferimenti |
| `"..."` | stringhe (percorsi, opzioni) |

I commenti `//` restano controllati: è voluto, così anche le note a margine
sono pulite.

## 4. `project-words.txt`

Un termine per riga. Parte vuoto e cresce da solo: con `"addWords": true`,
in VS Code il quick fix *Add to project-words* scrive direttamente qui.

```text
Tinymist
bisimulazione
automa
```

Conviene committarlo: è di fatto il glossario del corso.

## 5. Editor

- **VS Code**: estensione *Code Spell Checker* (`streetsidesoftware.code-spell-checker`).
  Legge `cspell.json` in automatico; `enableFiletypes` attiva il controllo sui
  file `.typ`.
- **Altri editor** (Neovim, Zed, Helix...): usa la CLI, oppure un language
  server basato su cspell se l'editor lo supporta.

## 6. Da terminale

```bash
npm run spell                       # tutto il repo
npx cspell capitoli/03-turing.typ   # un solo file
npx cspell --words-only --unique "**/*.typ" | sort   # elenco parole sospette
```

L'ultimo comando è utile la prima volta: scorri l'elenco e copia in
`project-words.txt` i termini corretti.

## 7. (Opzionale) Controllo automatico su GitHub

`.github/workflows/spell.yml`:

```yaml
name: spell
on: [push, pull_request]
jobs:
  cspell:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 22
      - run: npm ci
      - run: npm run spell
```

`npm ci` richiede che `package-lock.json` sia committato.

## Limiti noti

- Con `it,en` attivi insieme, un typo che forma una parola valida nell'altra
  lingua non viene segnalato.
- Le regex sono euristiche: i `\$` letterali sono esclusi, ma una formula
  lasciata aperta per errore fa saltare il controllo fino al `$` successivo.
  Per escludere a mano un punto problematico usa `// cspell:disable-next-line`.
- cspell trova errori di ortografia, non di grammatica o concordanza.