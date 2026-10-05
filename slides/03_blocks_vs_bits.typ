#import "../theme/mannot/ciphertext.typ": ciphertextmath
#import "../theme/touying/theme-crx.typ": slide, slide-margin
#import "../theme/boxes.typ": questionbox, propertybox, alertbox
#import "../theme/circuits/ciphertexts.typ": ciphertext-block, plaintext-block
#import "../theme/circuits/gates.typ": pbs-block, connect, add-block, clearmult-block
#import "@preview/touying:0.7.4": utils, alternatives, only
#import "@preview/cetz:0.5.2"

#slide( self =>{
  set text(size: 2em)
  set align(center+horizon)

  grid(
    columns: (auto, auto),
    column-gutter: 15pt,
    row-gutter: 1em,
    [$f:$], [$ZZ_p mapsto ZZ_p$], [], [$x -> y$]
  )


  questionbox(
    [Using TFHE basic operations, how do we compute $f$ homomorphically?]
  )
})



#slide(title: "Naive version", config: (detect-overflow: false), self => {

  set text(size: 1.3em)

  block(
    cetz.canvas({
      import cetz.draw: *

      ciphertext-block(
        (0, 0), "x", [$x$]
      )

      pbs-block(
        (5, 0), "pbs"
      )


      ciphertext-block(
        (10, 0), "y", [$f(x)$]
      )


      connect((
        ("x", "pbs"),
        ("pbs", "y")
      ))



    })
  )

  alertbox([Impractical when the size of the message space $p$ gets too large])

})







#slide(title: "A better version using chunks", repeat:2, config: (detect-overflow: false), self => {

  block(
    cetz.canvas({
      let typst-line = line
      import cetz.draw: *

      let spacing-block=0.7

      let midpoint-shift(shift, a, b) = (rel: (shift, 0), to:(a, 50%, b))
      for i in range(0, 6, inclusive:true){
        ciphertext-block(
          (0, (1 + spacing-block) * i), "x" + str(i), [$x_(#i)$]
        )
      }

      let anchor-points-y = ()
      for i in range(0, 6, inclusive:true){
        ciphertext-block(
          (20, (1 + spacing-block) * i), "y" + str(i), [$y_(#i)$]
        )
        anchor-points-y.push((rel:(-4, 0), to:"y" + str(i)))
      }


      if self.subslide >= 2 {
        add-block(midpoint-shift(3, "x0", "x1"), "add0")
        add-block(midpoint-shift(3, "x5", "x6"), "add1")
        plaintext-block((rel:(3, 0), to:"x4"), "alpha", $alpha$)
        pbs-block((rel:(3, 0), to:"x3"), "pbs3", content:[PBS])
        pbs-block((rel:(3, 0), to:"x2"), "pbs2", content:[PBS])


        clearmult-block(
          midpoint-shift(3, "add1", "alpha"),
          "mult1"
        )

        pbs-block((rel:(2.5, 0), to:"add0"), "pbs1", content:[PBS])
        add-block((rel:(2.5, 1.5), to:"pbs1"), "add2")


        connect((
          ("x0", "add0"),
          ("x1", "add0"),
          ("x5", "add1"),
          ("x6", "add1"),
          ("add1", "mult1"),
          ("alpha", "mult1"),
          ("x3", "pbs3"),
          ("x2", "pbs2"),
          ("mult1", (rel:(5, 0))),
          ("add0", "pbs1"),
          ("pbs3", (rel:(8, 0))),
          ("pbs2", "add2"),
          ("pbs2", "add2"),
          ("pbs1", "add2"),
          ("pbs1", (rel:(5.5, 0))),
          ("add2", (rel:(3, 0))),
        ))

        for i in range(0, 6, inclusive:true){
          connect((
            (anchor-points-y.at(i), "y" + str(i)),
          ))
        }


        line(
          (11, -1), (11, (1+spacing-block)*6+1), stroke:(dash:"dashed"), mark:none
        )
        line(
          (16, -1), (16, (1+spacing-block)*6+1), stroke:(dash:"dashed"), mark:none
        )

        let pat = tiling(size: (30pt, 30pt), {
          place(typst-line(start: (0%, 0%), end: (100%, 100%),stroke:black.transparentize(50%)))
          place(typst-line(start: (0%, 100%), end: (100%, 0%), stroke:black.transparentize(50%)))
        })


        rect(
          (11, -1),
          (16, (1 + spacing-block) * 6 + 1),
          stroke:0pt,
          fill: pat,
        )
      }
    })
)
})



#slide(self =>{

  questionbox([Given a function $f$, how to compile this circuit to make it the most efficient possible?])


  questionbox([How to dimension the chunks?])

})


#slide(title: "Reduction of the problem to one single output chunk:", config: (detect-overflow: false), self=>{
  {

    block(
      cetz.canvas({
        let typst-line = line
        import cetz.draw: *

        let spacing-block=0.7

        let midpoint-shift(shift, a, b) = (rel: (shift, 0), to:(a, 50%, b))
        for i in range(0, 6, inclusive:true){
          ciphertext-block(
            (0, (1 + spacing-block) * i), "x" + str(i), [$x_(#i)$]
          )
        }


        ciphertext-block(
            (20, (1 + spacing-block) * 3), "y", [$y$]
          )
        let anchor-point-y = (rel:(-4, 0), to:"y")




        add-block(midpoint-shift(3, "x0", "x1"), "add0")
        add-block(midpoint-shift(3, "x5", "x6"), "add1")
        plaintext-block((rel:(3, 0), to:"x4"), "alpha", $alpha$)
        pbs-block((rel:(3, 0), to:"x3"), "pbs3", content:[PBS])
        pbs-block((rel:(3, 0), to:"x2"), "pbs2", content:[PBS])


        clearmult-block(
          midpoint-shift(3, "add1", "alpha"),
          "mult1"
        )

        pbs-block((rel:(2.5, 0), to:"add0"), "pbs1", content:[PBS])
        add-block((rel:(2.5, 1.5), to:"pbs1"), "add2")


        connect((
          ("x0", "add0"),
          ("x1", "add0"),
          ("x5", "add1"),
          ("x6", "add1"),
          ("add1", "mult1"),
          ("alpha", "mult1"),
          ("x3", "pbs3"),
          ("x2", "pbs2"),
          ("mult1", (rel:(5, 0))),
          ("add0", "pbs1"),
          ("pbs3", (rel:(8, 0))),
          ("pbs2", "add2"),
          ("pbs2", "add2"),
          ("pbs1", "add2"),
          ("pbs1", (rel:(5.5, 0))),
          ("add2", (rel:(3, 0))),
        ))

        connect((
          (anchor-point-y, "y"),
        ))



        line(
          (11, -1), (11, (1+spacing-block)*6+1), stroke:(dash:"dashed"), mark:none
        )
        line(
          (16, -1), (16, (1+spacing-block)*6+1), stroke:(dash:"dashed"), mark:none
        )

        let pat = tiling(size: (30pt, 30pt), {
          place(typst-line(start: (0%, 0%), end: (100%, 100%),stroke:black.transparentize(50%)))
          place(typst-line(start: (0%, 100%), end: (100%, 0%), stroke:black.transparentize(50%)))
        })


        rect(
          (11, -1),
          (16, (1 + spacing-block) * 6 + 1),
          stroke:0pt,
          fill: pat,
        )

      })
  )
  }


})
