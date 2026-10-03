/// Riferimenti a label assenti mostrati come segnaposto invece di un errore.
///
/// Pensata per compilare un capitolo da solo: i riferimenti ad altri
/// capitoli (es. @cap:rice) non esistono in quel documento e Typst darebbe
/// errore. Da usare solo nella compilazione del singolo capitolo, non nel
/// documento completo, dove un riferimento mancante è un errore vero.
///
/// Vale solo per le label nella forma `tipo:nome` (con i due punti): le
/// chiavi bibliografiche (@sipser) non hanno i due punti e restano
/// citazioni normali. Il controllo non può usare i campi del riferimento
/// (`element`, `citation`): leggerli su una label assente produce
/// l'errore che si vuole evitare.
///
/// Usa context (query della label, implicita nella show rule).
///
/// - placeholder: funzione `label-string => content`.
#let rule-missing-refs(
  placeholder: name => text(fill: luma(120))[[#name]],
) = body => {
  show ref: it => {
    let name = str(it.target)
    if name.contains(":") and query(it.target).len() == 0 { placeholder(name) } else { it }
  }
  body
}
