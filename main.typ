#import "@preview/touying:0.7.4": config-info
#import "theme/touying/theme-crx.typ": crx-theme, title-slide



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


= Basics on TFHE scheme

#include "slides/01_tfhe_basics.typ"
#include "slides/02_perfs_pbs.typ"

= Circuit != Blocks

#include "slides/03_blocks_vs_bits.typ"
#include "slides/04_side_channels.typ"

= Our technique
#include "slides/05_dream_scenario.typ"
#include "slides/06_incremental_rationale.typ"
#include "slides/07_basis_extension_first_idea.typ"
#include "slides/08_second_idea.typ"
#include "slides/09_field.typ"
#include "slides/10_several_outputs.typ"

= Experimental Results
#include "slides/11_benchmarks.typ"

= Conclusion
#include "slides/12_conclusion.typ"
