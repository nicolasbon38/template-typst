#import "@preview/touying:0.7.4": *
#import "../colors.typ": *

#let slide-margin = 15mm




// Define a function slide() to call at each slide
#let slide-normal(title:auto, ..args) = touying-slide-wrapper( self => {
  let header(self) = {
    show: components.cell.with(inset: 1em)
    if title != auto {
      place(
        top + left,
        dx: slide-margin,
        dy: slide-margin,
        text(
          weight: "bold",
          size: 24pt,
          fill: self.colors.primary-dark,
          title,
        )
      )
        }
  }

  self = utils.merge-dicts(
    self,
    config-page(
      header: header
    )
  )


  touying-slide(self: self, ..args)

})


#let title-slide(..args) = touying-slide-wrapper( self => {
  let info = self.info + args.named()
  self = utils.merge-dicts(
    self,
    config-page(
      numbering: none,
      fill: self.colors.primary-darkest,
    ),
  )
  let body = {
    set text(font: "JetBrains Mono")

    let title-text = text(
      size: 34pt,
      weight: "bold",
      fill: self.colors.secondary,
      info.title,
    )
    let subtitle-text = text(size: 19pt, fill: self.colors.secondary, info.subtitle)
    let author-text = text(size: 17pt, fill: white, info.author)

    // A format for extra info
    let detail-text(body) = text(size: 15pt, fill: white, body)

    align(left + horizon)[
      #title-text
      #if info.subtitle != [] [
        #v(4mm)
        #subtitle-text
      ]
      #v(8mm)
      #author-text
    ]
    place(bottom + left)[#detail-text(info.extra.venue)]
    place(bottom + right)[#detail-text(info.date)]
  }


  touying-slide(self: self, body)
  }
)


#let new-section-slide(body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(
      numbering: none,
      fill: self.colors.primary-darkest,
    ),
  )

  touying-slide(self: self, {
    set text(font: "JetBrains Mono")

    let number = utils.display-current-heading-number(level: 1, numbering:"1")
    let title = utils.display-current-heading(
      level: 1,
      numbered: false,
    )

    align(left + horizon)[
      #text(
        size: 34pt,
        weight: "bold",
        fill: self.colors.secondary,
        [Part #number:],
      )

      #v(8mm)

      #text(size: 19pt, fill: white, title)

      #v(5mm)

      #align(center)[
        #line(
          length: 70%,
          stroke: self.colors.secondary + 5pt,
        )
      ]
    ]

    body
  })
})




#let new-subsection-slide(body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(
      numbering: none,
      fill: self.colors.primary-darkest.transparentize(10%),
    ),
  )

  touying-slide(self: self, {
    set text(font: "JetBrains Mono", size:19pt)

    let section-title = text(fill: self.colors.secondary, utils.display-current-heading(
      level:1,
      numbered: false,
    ))
    let subsection-title = text(fill:white, utils.display-current-heading(
      level:2,
      numbered: false,
    ))


    let horizon-bar = align(center)[
      #line(length: 50%, stroke:self.colors.secondary + 5pt)
    ]

    align(left + horizon)[
      #section-title
      #v(8mm)
      #subsection-title
      #v(5mm)
      #horizon-bar
    ]

    body
  })
})


// Registration of the theme with some defaults to be applied to all slides
#let crx-theme(
    ..args,
    body
) = {

  set text(font: "STIXTwo Text", size: 18pt, fill: crxdark)
  set align(left + horizon)
  // Touying hides the source headings, but Typst still needs a numbering
  // pattern for the heading counter to advance.
  set heading(numbering: "1.1")

  show: touying-slides.with(
    config-page(
      paper: "presentation-16-9",
      margin: slide-margin,
      fill: crxlight,
      foreground: {
        rect(
          width: 100%,
          height: 100%,
          fill: none,
          stroke: 10pt + crxaccent,
        )
      }
    ),
    config-common(
      breakable:false,
      detect-overflow: true,
      slide-fn: slide-normal,
      new-section-slide-fn: new-section-slide,
      new-subsection-slide-fn: new-subsection-slide
    ),
    config-colors(
      primary-light: crxlight,
      primary-dark: crxdark,
      primary-darkest: crxdarkbg,
      secondary: crxaccent
    ),
    // To manage title
    config-store(
    ),
    ..args,
  )

  body
}
