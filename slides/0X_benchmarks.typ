#import "../theme/touying/theme-crx.typ": slide
#import "@preview/lilaq:0.6.0" as lq


#let data-to-int(data) = data.map({couple => couple.map(value => int(value))})

#let load-data-csv(path) = data-to-int(
  csv(
    path,
    delimiter:",",
    row-type: array
  )
)

#let load-data-json(path) = {
  let data = json(path)

  let clean-data = (:)

  for p in data.keys(){
    clean-data.insert(p, data-to-int(data.at(p).pairs()))
  }

  clean-data
}


#let prepare-x-y-data(data) = {
  data = data.sorted(key:s => s.at(0), by:(l, r) => l>=r)
  let x-values = data.map(couple => couple.at(0))
  let y-values = data.map(couple => couple.at(1))
  (x-values, y-values)
}



#let plot-benchs(subslide: 4, legend-fill: white) = {

  let plot = lq.plot.with(
    stroke: 1pt,
    mark-size: 8pt,
  )

  // Keep hidden curves in the diagram so automatic axis limits stay fixed.
  let reveal-plot(step, ..args) = {
    let options = args.named()
    options.label = text(size: 12pt, options.label)
    if subslide < step {
      options.color = options.color.transparentize(100%)
      options.mark = none
      options.label = none
    }
    plot(..args.pos(), ..options)
  }

  let data-cjp = load-data-csv(
    "../assets/csv/perfs-pbs.csv",
  )

  let data-hlut-40 = load-data-json("../assets/json/timings_hlut-40.json")
  let data-wop-pbs = load-data-json("../assets/json/timings_wop-pbs.json")
  let data-tbm = load-data-json("../assets/json/timings_tbm.json")

  lq.diagram(
    width: 80%,
    height: 13cm,
    xlim: auto,
    ylim: auto,
    xlabel: [$p$ (in bits)],
    ylabel: [Running time(ms)],
    yscale: "log",
    grid: none,
    legend: (
      position: top + left,
      fill: legend-fill,
      stroke: none,
      z-index: 1,
    ),
    reveal-plot(1,
      ..prepare-x-y-data(data-cjp),
      color: blue,
      mark: lq.marks.o,
      label: [CJP],
    ),
    reveal-plot(2,
      ..prepare-x-y-data(data-hlut-40.at("3")),
      color: green,
      mark: lq.marks.d,
      label: [Our work (3)],
    ),
    reveal-plot(2,
      ..prepare-x-y-data(data-hlut-40.at("5")),
      color: green.lighten(20%),
      mark: lq.marks.d,
      label: [Our work (5)],
    ),
    reveal-plot(2,
      ..prepare-x-y-data(data-hlut-40.at("17")),
      color: green.lighten(40%),
      mark: lq.marks.d,
      label: [Our work (17)],
    ),
    reveal-plot(3,
      ..prepare-x-y-data(data-wop-pbs.at("1 blocks")),
      color: red,
      mark: lq.marks.s,
      label: [WOP-PBS (1 block)],
      stroke: (thickness: 1pt, dash: "dashed"),

    ),
    reveal-plot(3,
      ..prepare-x-y-data(data-wop-pbs.at("2 blocks")),
      color: red.lighten(20%),
      mark: lq.marks.s,
      label: [WOP-PBS (2 blocks)],
      stroke: (thickness: 1pt, dash: "dashed"),

    ),
    reveal-plot(3,
      ..prepare-x-y-data(data-wop-pbs.at("4 blocks")),
      color: red.lighten(40%),
      mark: lq.marks.s,
      label: [WOP-PBS (4 blocks)],
      stroke: (thickness: 1pt, dash: "dashed"),

    ),
    reveal-plot(4,
      ..prepare-x-y-data(data-tbm.at("2 blocks")),
      color: fuchsia,
      mark: lq.marks.v,
      label: [TBM (2 blocks)],
      stroke: (thickness: 1pt, dash: "dashed"),

    ),
    reveal-plot(4,
      ..prepare-x-y-data(data-tbm.at("3 blocks")),
      color: fuchsia.lighten(30%),
      mark: lq.marks.v,
      label: [TBM (3 blocks)],
      stroke: (thickness: 1pt, dash: "dashed"),
    ),
  )
}



#slide(repeat: 4, self=>{

  figure(
    plot-benchs(
      subslide: self.subslide,
      legend-fill: self.colors.primary-light,
    )
  )

})
