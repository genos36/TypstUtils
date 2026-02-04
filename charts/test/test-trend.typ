#import "../modules/KPI-chart.typ": *
#import "../modules/_render-trend.typ": *
#import "../modules/csv-parser.typ": *

#let data = parse-csv-to-columns("../data/mockup-tren.csv")
#_render-trend(data, "title_placeholder", y-label: "valore", target: ("Ottimo": 90, "Accettabile": 60))

#_render-trend(
  data,
  "title_placeholder",
  y-label: "valore",
  target: ("Ottimo": 90, "Accettabile": 60),
)

#data
#{ range(0, 4).map(i => { data.x-labels.at(int(i), default: "") }) }

