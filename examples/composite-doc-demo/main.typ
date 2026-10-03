#import "common.typ": *
#import "chapters/turing.typ" as turing
#import "chapters/rice.typ" as rice

#show: course-notes
#preface(outlines: ("heading",))[#title-page(meta: meta)]

#turing.body
#rice.body

#course-bib()
