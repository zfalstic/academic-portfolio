#import "@preview/noteworthy:0.3.0": *

#show: noteworthy.with(
  paper-size: "us-letter",
  font: "New Computer Modern",
  language: "EN",
  title: "MIS 301H Notes",
  header-title: "MIS 301H",
  author: "Dawson Zhang",
  contact-details: "dawsonzhang@utexas",
  toc-title: "Table of Contents",
)

#show link: underline

// Reset the figure counter at each top-level heading
#show heading.where(level: 1): it => {
  counter(figure.where(kind: image)).update(0)
  it
}

// Number figures as <section>.<figure>
#set figure(numbering: n => {
  let h = counter(heading).get()
  numbering("1.1", h.first(), n)
})

#pagebreak()
= Blockchain

#definition[
  A *blockchain* is a digital, chronologically updated, distributed
  and cryptographically sealed record of all data transfer activity.
  It is a distributed ledger (database) that maintains all records
  and transactions without central authority. Network approves a
  block of transaction and is then added to the previous chain of
  blocks.
]

- Permissioned: Restricted to only approved and trusted participants
- Unpermissioned: Anyone can participate

*Key Attributes of Blockchain*

- Transparency
- Immutability
- Anonymity
- Security
- Builds trust

Blockchain is most applicable under scenarios where there is a need
and high cost of verification: i.e. authentication of assets (both
tangible and intangible) and trasactions. Additionally, blockchain
is also applicable whenever there are delays due to intermediaries
like centralized processing and verification and those intermediaries
take a cut / commission.


