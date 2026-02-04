#import "/charts/modules/KPI-chart.typ": *
#import "/charts/modules/csv-parser.typ": *

#let data = parse-csv-to-columns("../data/mockup-multi.csv")
#_render-multi(
  data,
  "title_placeholder",
  y-label: "valore",
  target: ("Ottimo": 90, "Accettabile": 60),
)

#data
#{ range(0, 4).map(i => { data.x-labels.at(int(i), default: "") }) }



#kpi-chart(
  "../test/IndiciT.csv",
  type: "multi",
  title: "",
)





#parse-csv-to-columns("../test/Indici.csv")


ggaelrngjerw