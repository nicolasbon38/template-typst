#import "colors.typ": *


#let title-slide(
  title: [],
  subtitle: [],
  author: [],
  date: [],
  venue: [],
) = [
  #set page(
    "presentation-16-9",
    numbering: none,
    fill: crxdarkbg,
  )

  #set text(font: "JetBrains Mono")

  #let title-text = text(
    size: 34pt,
    weight: "bold",
    fill: crxaccent,
    title,
  )
  #let subtitle-text = text(size: 19pt, fill: crxaccent, subtitle)
  #let author-text = text(size: 17pt, fill: white, author)
  #let detail-text(body) = text(size: 15pt, fill: white, body)

  #align(left + horizon)[
    #title-text
    #if subtitle != [] [
      #v(4mm)
      #subtitle-text
    ]
    #v(8mm)
    #author-text
  ]
  #place(bottom + left)[#detail-text(venue)]
  #place(bottom + right)[#detail-text(date)]

  #pagebreak()
]
