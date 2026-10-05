#import "../../theme/touying/theme-crx.typ": slide
#import "@preview/lilaq:0.6.0" as lq


#let plot-perfs-pbs(line-color) = {
  let data = csv(
    "../../assets/csv/perfs-pbs.csv",
    delimiter:",",
    row-type: array
  )

  let data-clean = data.map(
    couple => couple.map(value => int(value)),
  )

  let x-values = data-clean.map(couple => couple.at(0))
  let y-values = data-clean.map(couple => couple.at(1))

  lq.diagram(
    width: 80%,
    height: 9cm,
    title: [*PBS performance degrades with the size of the input*],
    xlim: auto,
    ylim: auto,
    xlabel: [$p$ (in bits)],
    ylabel: [Running time of PBS (ms)],
    grid: none,
    lq.plot(
      x-values,
      y-values,
      color: line-color,
      stroke:3pt,
      mark: lq.marks.star,
      mark-size:12pt
    ),
  )

}



#slide(self => {

  set align(center+horizon)

  figure(
    plot-perfs-pbs(self.colors.primary-dark)
  )


})
