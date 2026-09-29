// Manipolazione di stringhe: conversioni di formato (kebab, snake, camel,
// pascal), utili per costruire chiavi di dizionari, label e nomi di file a
// partire da testo libero.
//
// Tutte le conversioni passano da `words`, che divide il testo in parole:
//   "  Macchina di Turing "  → ("macchina", "di", "turing")
//   "macchinaDiTuring"       → ("macchina", "di", "turing")
//   "macchina_di-turing"     → ("macchina", "di", "turing")
//
// Accettano stringhe o content semplice (testo, spazi, enfasi), così si
// possono usare direttamente sul contenuto di una lista.

// Vocali accentate comuni → ASCII, usato con `ascii: true`.
#let _accents = (
  "à": "a", "á": "a", "è": "e", "é": "e", "ì": "i", "í": "i",
  "ò": "o", "ó": "o", "ù": "u", "ú": "u",
  "À": "A", "Á": "A", "È": "E", "É": "E", "Ì": "I", "Í": "I",
  "Ò": "O", "Ó": "O", "Ù": "U", "Ú": "U",
)

/// Testo semplice da stringa o content (testo, spazi, enfasi, sequenze).
/// Elementi senza testo (immagini, formule...) vengono ignorati.
#let to-string(value) = {
  if type(value) == str { return value }
  if value == none { return "" }
  assert(type(value) == content, message: "to-string: atteso str o content, ricevuto " + str(type(value)))
  if value.has("text") { return value.text }
  if value.has("children") { return value.children.map(to-string).join() }
  if value.has("body") { return to-string(value.body) }
  if value == [ ] { return " " }
  ""
}

/// Divide il testo in parole minuscole.
///
/// - value: stringa o content.
/// - ascii: sostituisce le vocali accentate con quelle semplici.
#let words(value, ascii: false) = {
  let s = to-string(value).trim()
  if ascii {
    for (from, to) in _accents { s = s.replace(from, to) }
  }
  // confine camelCase: "diTuring" → "di Turing"
  s = s.replace(regex("([\p{Ll}\p{N}])(\p{Lu})"), m => m.captures.at(0) + " " + m.captures.at(1))
  s.split(regex("[^\p{L}\p{N}]+")).filter(w => w != "").map(lower)
}

// Prima lettera maiuscola.
#let _capitalize(w) = {
  let cs = w.clusters()
  upper(cs.first()) + cs.slice(1).sum(default: "")
}

/// "Macchina di Turing" → "macchina-di-turing"
#let to-kebab(value, ascii: false) = words(value, ascii: ascii).join("-", default: "")

/// "Macchina di Turing" → "macchina_di_turing"
#let to-snake(value, ascii: false) = words(value, ascii: ascii).join("_", default: "")

/// "Macchina di Turing" → "macchinaDiTuring"
#let to-camel(value, ascii: false) = {
  let ws = words(value, ascii: ascii)
  if ws.len() == 0 { return "" }
  ws.first() + ws.slice(1).map(_capitalize).sum(default: "")
}

/// "Macchina di Turing" → "MacchinaDiTuring"
#let to-pascal(value, ascii: false) = words(value, ascii: ascii).map(_capitalize).sum(default: "")