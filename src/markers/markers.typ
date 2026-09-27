// Marcatori di revisione: cose da fare e domande per il docente.
//
// Sono figure con un kind del registro, quindi numerati e raccolti negli
// indici senza infrastruttura aggiuntiva:
//   #preface(outlines: ("heading", "todo", "ask"))[...]
// oppure in fondo al documento: #make-outline(spec: "todo")
//
// Il testo breve è la didascalia (compare nell'indice); i dettagli
// facoltativi compaiono solo nel testo. L'aspetto lo decide `rule-markers`.

#import "/src/shared/custom-kinds.typ": kinds, kind-figure

/// Marcatore generico di un kind del registro.
///
/// - kind: voce del registro, es. `kinds.todo`.
/// - detail: dettagli facoltativi, non riportati nell'indice.
/// - body: testo breve del marcatore.
#let marker(kind: none, detail: none, body) = kind-figure(
  kind: kind,
  caption: body,
  if detail == none { [] } else { detail },
)

/// Cosa da fare: parte da completare, verificare, riscrivere.
#let todo(detail: none, body) = marker(kind: kinds.todo, detail: detail, body)

/// Domanda da fare al docente.
#let ask(detail: none, body) = marker(kind: kinds.ask, detail: detail, body)