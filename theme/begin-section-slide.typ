#import "colors.typ": *



#let begin-section(
  number: [],
  title: []
) = [
  #set page(
    numbering: none,
    fill: crxdarkbg,
  )

  #set text(font: "JetBrains Mono")

  #let header-text = text(
    size: 34pt,
    weight: "bold",
    fill: crxaccent,
    [Step #number:],
  )
  #let title-text = text(size: 19pt, fill: crxaccent, title)
  #let horizon-bar = align(center)[
    #line(length: 70%, stroke: crxaccent + 5pt)
  ]

  #align(left + horizon)[
    #header-text
    #v(8mm)
    #title-text
    #v(5mm)
    #horizon-bar
  ]
  #pagebreak()
]
