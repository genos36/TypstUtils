/// Applica un preset di regole con eventuali modifiche del progetto.
///
/// - preset: dizionario `nome: (rule: factory, args: (..))`.
/// - rules: modifiche per nome:
///     dizionario → unito agli argomenti del preset (cambia solo quelli)
///     funzione   → sostituisce la regola (es. rule-page(...) o body => ...)
///     none       → disattiva la regola
/// - extra: regole aggiuntive (funzioni body => ...), applicate per ultime.
///
/// Priorità: vince la regola che viene dopo (preset nell'ordine, poi extra),
/// come scrivere più `#show:` uno dopo l'altro.
#let compose(preset: (:), rules: (:), extra: (), body) = {
  assert(
    type(preset) == dictionary,
    message: "compose: `preset` deve essere un dizionario, ricevuto " + str(type(preset))
      + if type(preset) == function { " (una funzione di preset va chiamata, es. notes-preset(meta: meta))" } else { "" },
  )
  assert(type(rules) == dictionary, message: "compose: `rules` deve essere un dizionario")
  assert(type(extra) == array, message: "compose: `extra` deve essere un array di regole")
  for name in rules.keys() {
    assert(name in preset, message: "compose: regola sconosciuta `" + name + "`; disponibili: " + preset.keys().join(", "))
  }
  let active = ()
  for (name, entry) in preset {
    let o = rules.at(name, default: (:))
    if o == none { continue }
    if type(o) == function {
      active.push(o)
    } else {
      assert(type(o) == dictionary, message: "compose: `" + name + "` accetta un dizionario di argomenti, una funzione o none")
      active.push((entry.rule)(..entry.args + o))
    }
  }
  (active + extra).rev().fold(body, (acc, r) => r(acc))
}/// Applica un preset di regole con eventuali modifiche del progetto.
///
/// - preset: dizionario `nome: (rule: factory, args: (..))`.
/// - rules: modifiche per nome:
///     dizionario → unito agli argomenti del preset (cambia solo quelli)
///     funzione   → sostituisce la regola (es. rule-page(...) o body => ...)
///     none       → disattiva la regola
/// - extra: regole aggiuntive (funzioni body => ...), applicate per ultime.
///
/// Priorità: vince la regola che viene dopo (preset nell'ordine, poi extra),
/// come scrivere più `#show:` uno dopo l'altro.
#let compose(preset: (:), rules: (:), extra: (), body) = {
  assert(
    type(preset) == dictionary,
    message: "compose: `preset` deve essere un dizionario, ricevuto " + str(type(preset))
      + if type(preset) == function { " (una funzione di preset va chiamata, es. notes-preset(meta: meta))" } else { "" },
  )
  assert(type(rules) == dictionary, message: "compose: `rules` deve essere un dizionario")
  assert(type(extra) == array, message: "compose: `extra` deve essere un array di regole")
  for name in rules.keys() {
    assert(name in preset, message: "compose: regola sconosciuta `" + name + "`; disponibili: " + preset.keys().join(", "))
  }
  let active = ()
  for (name, entry) in preset {
    let o = rules.at(name, default: (:))
    if o == none { continue }
    if type(o) == function {
      active.push(o)
    } else {
      assert(type(o) == dictionary, message: "compose: `" + name + "` accetta un dizionario di argomenti, una funzione o none")
      active.push((entry.rule)(..entry.args + o))
    }
  }
  (active + extra).rev().fold(body, (acc, r) => r(acc))
}