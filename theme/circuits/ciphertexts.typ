#import "@preview/cetz:0.5.2"
#import "../mannot/ciphertext.typ": ciphertextmath, plaintextmath


//this function mimic the mannot one, but for cetz block
#let ciphertext-block(position, label, body) = {
  import cetz.draw: content

  content(
    position,
    name: label,
    box(
      math.equation(ciphertextmath(body)),
      inset: 6pt,
    ),
  )
}



#let plaintext-block(position, label, body) = {
  import cetz.draw: content

  content(
    position,
    name: label,
    box({

      $#plaintextmath(body)$
    },
      inset: 6pt
    ),
  )
}
