#import "colors.typ": *



#let begin-subsection(
  number: [],
  subnumber: [],
  section-title: [],
  title: [],
) = [
  #set page(
    numbering: none,
    fill: crxdarkbg.transparentize(10%),
  )

  #set text(font: "JetBrains Mono")

  #let header-text = text(
    size: 34pt,
    weight: "bold",
    fill: crxaccent,
    [#number.#subnumber:],
  )

  #let section-title-text = text(size: 19pt, fill: crxaccent, section-title)
  #let title-text = text(size: 19pt, fill: white, title)
  #let horizon-bar = align(center)[
    #line(length: 50%, stroke: crxaccent + 5pt)
  ]

  #align(left + horizon)[
    #header-text
    #v(8mm)
    #section-title-text
    #v(8mm)
    #title-text
    #v(5mm)
    #horizon-bar
  ]
  #pagebreak()
]
