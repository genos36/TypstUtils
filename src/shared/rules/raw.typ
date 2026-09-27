/// Dimensione del codice (inline e a blocchi) rispetto al testo.
#let rule-raw(size: 0.85em) = body => {
  show raw: set text(size: size)
  body
}