#import "colors.typ": *

#let slide-margin = 15mm

#let slide-foreground = context {
  let page-titles = query(<slide-title>).filter(
    item => item.location().page() == here().page()
  )

  rect(
    width: 100%,
    height: 100%,
    fill: none,
    stroke: 10pt + crxaccent,
    if page-titles.len() > 0 {
      place(
        top + left,
        dx: slide-margin,
        dy: slide-margin,
        text(
          weight: "bold",
          size: 24pt,
          fill: crxdark,
          page-titles.first().value,
        ),
      )
    },
  )
}

#let slides(body) = [
  #set page(
    "presentation-16-9",
    margin: slide-margin,
    fill: crxlight,
    foreground: slide-foreground,
    footer: context[
      #set align(right)
      #set text(8pt)
      #counter(page).display(
            "1/1",
            both: true,
          )
    ]
  )

  #set text(font: "STIXTwo Text", size: 18pt, fill: crxdark)
  #set align(left + horizon)
  #show title: slide-title => [
    #metadata(slide-title.body) <slide-title>
  ]

  #body
]


#let slide(body) = [
  #pagebreak(weak: true)
  #body
]
