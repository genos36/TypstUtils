#import "/src/shared/rules/styles.typ": style-internal-ref, style-external-link

/// Stile dei link: URL esterni e link interni (a label) distinti.
/// Gli stili sono funzioni `body => content`, sostituibili.
#let rule-links(
  external: style-external-link,
  internal: style-internal-ref,
) = body => {
  show link: it => if type(it.dest) == str { external(it) } else { internal(it) }
  body
}