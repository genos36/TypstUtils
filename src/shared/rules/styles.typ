// Stili riutilizzabili per link e riferimenti.
// Esportati anche da lib.typ, così si possono usare nel testo
// (es. in una legenda delle convenzioni tipografiche).

#let external-blue = rgb("#0645AD")

/// Stile dei collegamenti interni: riferimenti, link a label.
#let style-internal-ref(body) = underline(text(weight: "semibold", body))

/// Stile dei collegamenti esterni: URL.
#let style-external-link(body) = underline(text(fill: external-blue, body))