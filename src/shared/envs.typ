// Ambienti matematici: parte semantica.
//
// Ogni ambiente è una figura con un kind del registro: numerazione,
// riferimenti (@label) e indici funzionano come per le altre figure.
// L'aspetto grafico lo decide `rule-envs`; senza quella regola gli
// ambienti compaiono come figure standard.
//
// I nomi sono in italiano; per un'altra lingua, nel progetto:
//   #let theorem = theorem.with(supplement: [Theorem])

#import "/src/shared/custom-kinds.typ": kinds, kind-figure

/// Ambiente generico di un kind del registro.
///
/// - kind: voce del registro, es. `kinds.thm`.
/// - supplement: nome dell'ambiente; auto → quello del registro.
/// - title: titolo facoltativo, mostrato tra parentesi (es. [Rice]).
/// - body: contenuto.
#let env(kind: none, supplement: auto, title: none, body) = {
  let args = (kind: kind, caption: title)
  if supplement != auto { args.insert("supplement", supplement) }
  kind-figure(..args, body)
}

// Teorema, lemma, corollario e proposizione condividono la numerazione.
#let theorem(supplement: [Teorema], title: none, body) = env(kind: kinds.thm, supplement: supplement, title: title, body)
#let lemma(supplement: [Lemma], title: none, body) = env(kind: kinds.thm, supplement: supplement, title: title, body)
#let corollary(supplement: [Corollario], title: none, body) = env(kind: kinds.thm, supplement: supplement, title: title, body)
#let proposition(supplement: [Proposizione], title: none, body) = env(kind: kinds.thm, supplement: supplement, title: title, body)

#let definition(supplement: [Definizione], title: none, body) = env(kind: kinds.definition, supplement: supplement, title: title, body)
#let example(supplement: [Esempio], title: none, body) = env(kind: kinds.example, supplement: supplement, title: title, body)

/// Dimostrazione: non numerata, non referenziabile, chiusa da ∎.
///
/// - title: intestazione (es. [Dimostrazione del Lemma 3]).
/// - qed: simbolo finale, none per ometterlo.
#let proof(title: [Dimostrazione], qed: sym.square.stroked, body) = block(
  width: 100%,
  breakable: true,
  {
    emph(title)
    [. ]
    body
    if qed != none { h(1fr); qed }
  },
)