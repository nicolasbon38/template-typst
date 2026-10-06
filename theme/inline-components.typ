#import "@preview/cetz:0.5.2"
#import "../theme/circuits/gates.typ": pbs-block

#let pbs-example(label) = cetz.canvas({
  pbs-block((0, 0), label, content: [PBS])
})


#let pbs-inline(label) = box(
  baseline: 25%,
  scale(60%, reflow: true, pbs-example(label)),
)
