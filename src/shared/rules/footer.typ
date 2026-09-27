#import "/src/shared/slots.typ": three-slots, slots-empty

/// Numero di pagina da mettere in una posizione di header o footer.
/// Usa context (legge il contatore delle pagine).
///
/// - numbering: auto → la numerazione impostata sulla pagina
///   (o "1" se non impostata), altrimenti un pattern (es. "1 / 1").
#let page-num(numbering: auto) = context {
  let pattern = if numbering != auto { numbering }
    else if page.numbering != none { page.numbering }
    else { "1" }
  counter(page).display(pattern, both: pattern.contains("/"))
}

/// Piè di pagina su tre posizioni.
/// Se tutte le posizioni sono vuote la regola non cambia nulla e resta la
/// numerazione standard di Typst (vedi `rule-page`). Se invece se ne usa
/// almeno una, il numero di pagina va inserito esplicitamente con
/// `page-num()`, perché un footer personalizzato sostituisce quello standard.
///
/// - left, center, right: contenuto delle posizioni.
/// - size: dimensione del testo rispetto al corpo.
/// - line: filetto sopra il piè di pagina (stroke), none per disattivarlo.
/// - gap: spazio tra filetto e testo.
#let rule-footer(
  left: none,
  center: none,
  right: none,
  size: 0.85em,
  line: none,
  gap: 4pt,
) = body => {
  if slots-empty(left: left, center: center, right: right) { return body }
  let row = text(size: size, three-slots(left: left, center: center, right: right))
  let footer = if line == none { row } else {
    block(width: 100%, stroke: (top: line), inset: (top: gap), row)
  }
  set page(footer: footer)
  body
}
