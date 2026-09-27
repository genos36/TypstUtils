#import "/src/shared/slots.typ": three-slots, slots-empty

/// Intestazione di pagina su tre posizioni.
/// Se tutte le posizioni sono vuote la regola non cambia nulla.
///
/// - left, center, right: contenuto delle posizioni.
/// - size: dimensione del testo rispetto al corpo.
/// - line: filetto sotto l'intestazione (stroke), none per disattivarlo.
/// - gap: spazio tra testo e filetto.
#let rule-header(
  left: none,
  center: none,
  right: none,
  size: 0.85em,
  line: 0.4pt + luma(150),
  gap: 4pt,
) = body => {
  if slots-empty(left: left, center: center, right: right) { return body }
  let row = text(size: size, three-slots(left: left, center: center, right: right))
  let header = if line == none { row } else {
    block(width: 100%, stroke: (bottom: line), inset: (bottom: gap), row)
  }
  set page(header: header)
  body
}