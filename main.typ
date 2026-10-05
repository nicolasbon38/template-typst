#import "@preview/touying:0.7.4": *
#import "theme/touying/theme-crx.typ": crx-theme, slide, title-slide



#show: crx-theme.with(
  config-info(
      title: [Decomposition of Large Look-Up Tables for Fast Homomorphic Evaluation],
      subtitle: [],
      author: [Sonia Belaïd, *Nicolas Bon*, Matthieu Rivain],
      date: [October 14, 2026],
      institution: [*CryptoExperts*],
      extra: (venue: [CHES 2026, Antalya, Turkey],)
  )
)


#title-slide()


= Intro TFHE

#include "slides/04_ideas/01_tfhe_basics.typ"
#include "slides/04_ideas/02_perfs_pbs.typ"

= Circuit != Blocks

#include "slides/04_ideas/03_blocks_vs_bits.typ"
#include "slides/04_ideas/04_side_channels.typ"

= Our technique
#include "slides/04_ideas/05_incremental_rationale.typ"
#include "slides/04_ideas/0X_field.typ"
#include "slides/04_ideas/0X_several_outputs.typ"


= Experimental Results
#include "slides/04_ideas/0X_benchmarks.typ"

= Conclusion
#include "slides/04_ideas/0X_conclusion.typ"
