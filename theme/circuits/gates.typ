#import "@preview/cetz:0.5.2"
#import cetz.draw: set-style, content, line
#import "../colors.typ": primary-dark, primary


#let pat-linear(color) = gradient.linear(
  color.transparentize(70%),
  color.transparentize(30%),
  angle: 45deg
)

#let operator-style = (
  inset: 0.4cm,
  stroke: 2pt + primary,
  fill: pat-linear(primary),
  radius: 0.30cm,
)


#let operator-block(position, label, body) = {
  content(
    position,
    name: label,
    box(
      {
        set text(fill: primary-dark, size: 18pt, weight:"semibold")
        align(center + horizon, body)
      },
      ..operator-style,
    ),
  )
}



#let add-block(position, label) = {
  operator-block(position, label, [+])
}

#let clearmult-block(position, label) = {
  operator-block(position, label, $bullet$)
}

#let pbs-block(position, label, content:[PBS\ $f(dot)$]) = {
  operator-block(position, label, content)
}


#let connect(connections) = {
  set-style(
    line: (
      stroke: 1.2pt + black,
      mark: (end: ">"),
    ),
  )

  for connection in connections {
    line(..connection)
  }
}
