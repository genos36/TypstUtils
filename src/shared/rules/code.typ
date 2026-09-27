#import "/src/packages.typ": codly-lib, codly-languages-lib

/// Blocchi di codice con codly: numeri di riga, righe alternate, icone e
/// nomi dei linguaggi. Non tocca il codice inline. La dimensione del codice
/// resta a `rule-raw`.
///
/// - languages: linguaggi riconosciuti (default: codly-languages).
/// - zebra-fill: colore delle righe alternate.
/// - font: font del codice, none per lasciare quello di Typst.
/// - breakable: le figure di codice possono spezzarsi tra pagine.
/// - options: altri argomenti passati così come sono a `codly(..)`,
///   es. (number-format: none, display-icon: false).
#let rule-code(
  languages: codly-languages-lib.codly-languages,
  zebra-fill: luma(246),
  font: none,
  breakable: true,
  options: (:),
) = body => {
  show: codly-lib.codly-init
  codly-lib.codly(languages: languages, zebra-fill: zebra-fill, ..options)
  show raw: it => if font != none { set text(font: font); it } else { it }
  show figure.where(kind: raw): set block(breakable: breakable)
  body
}