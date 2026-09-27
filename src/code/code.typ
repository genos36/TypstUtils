// Codice: figure di codice e funzioni di codly riesportate.
//
// Il progetto usa queste funzioni invece di importare codly da sé, così
// la versione di codly resta quella di /src/packages.typ.

#import "/src/packages.typ": codly-lib

// Funzioni di codly per le modifiche locali ai blocchi di codice.
#let codly = codly-lib.codly
#let codly-local = codly-lib.local
#let no-codly = codly-lib.no-codly
#let codly-range = codly-lib.codly-range
#let codly-offset = codly-lib.codly-offset
#let codly-skip = codly-lib.codly-skip
#let codly-enable = codly-lib.codly-enable
#let codly-disable = codly-lib.codly-disable

/// Blocco di codice come figura ("Listato N"), numerato e referenziabile.
/// La possibilità di spezzarsi tra pagine la decide `rule-code`.
///
/// - caption: didascalia.
/// - label: alternativa a `<label>` dopo la chiamata.
/// - body: il blocco di codice (```lang ... ```).
///
///   #code-fig(caption: [Passo della macchina])[```python
///   def step(q, a): ...
///   ```] <lst:step>
#let code-fig(caption: none, label: none, body) = {
  let fig = figure(kind: raw, caption: caption, body)
  if label == none { return fig }
  let lbl = if type(label) == str { std.label(label) } else { label }
  [#fig#lbl]
}