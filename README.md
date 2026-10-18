# Causal Inference in the Social Sciences: A Design-First Introduction

Materials for a **one-day MSc/PhD workshop** (MY580, London School of Economics) introducing causal inference in the social sciences. The workshop is a gentle introduction to *thinking causally*. It focuses on research design rather than statistical machinery: counterfactuals, the experimental ideal, and how experiments and observational designs try to approximate it.

📄 **Full syllabus:** [`syllabi/syllabus.pdf`](syllabi/syllabus.pdf)

📖 **Core text:** Nick Huntington-Klein, [*The Effect: An Introduction to Research Design and Causality*](https://theeffectbook.net) (free online)

## Schedule

The workshop has 4 contact hours plus a 1-hour lunch. Each of the two main blocks ends with a hands-on lab in R.

| Time | Block | Format |
|---|---|---|
| 10:00–10:50 | **1. Foundations:** potential outcomes, counterfactuals, the fundamental problem of causal inference, the experimental ideal | Lecture |
| 10:50–11:00 | *Break* | |
| 11:00–11:30 | **2a. Experiments:** why randomization works, estimation, threats to validity | Lecture |
| 11:30–12:00 | **2b. Lab 1:** simulating potential outcomes and randomization | Lab |
| 12:00–13:00 | *Lunch* | |
| 13:00–13:50 | **3a. Observational studies:** DAGs, confounding, selection bias; DiD, RD and IV | Lecture |
| 13:50–14:20 | **3b. Lab 2:** difference-in-differences | Lab |
| 14:20–14:30 | *Break* | |
| 14:30–14:55 | **4. Advanced topics:** staggered DiD, synthetic control, sensitivity analysis, heterogeneous effects and ML, interference and mediation | Lecture |
| 14:55–15:00 | Wrap-up | |

## Learning goals

By the end of the workshop, participants will be able to:
- Turn a social science question into a **causal question** with a clear counterfactual and estimand.
- Explain the **fundamental problem of causal inference**, and why naive comparisons suffer from **selection bias**.
- Explain **why randomization works**, and spot common threats to experiments.
- Use **DAGs** to state causal assumptions and to find confounders and colliders.
- Explain the identifying assumptions behind **difference-in-differences**, **regression discontinuity** and **instrumental variables**, and run and interpret a simple DiD.

## Labs

Open the `.qmd` files in RStudio to run the code, or view the rendered `.html` versions.

- **Lab 1: Playing God with potential outcomes** ([`code/lab1_experiments.qmd`](code/lab1_experiments.qmd)). Simulate data where both potential outcomes are known, show how self-selection biases naive estimates, and show how randomization recovers the true effect. Extension: noncompliance, ITT and CACE.
- **Lab 2: Difference-in-differences** ([`code/lab2_did.qmd`](code/lab2_did.qmd)). Did President Trump's April 2020 "LIBERATE" tweets reduce compliance with COVID-19 lockdowns? Uses Google county mobility data to draw the DAG, check pre-trends, estimate a 2×2 DiD (by hand, with regression and with two-way fixed effects) and run an event study with `fixest`.

## Repository contents

```
├── syllabi/
│   ├── syllabus.tex         # LaTeX source for the syllabus
│   └── syllabus.pdf         # Compiled syllabus
├── slides/
│   ├── main.qmd             # Quarto (revealjs) slide deck
│   ├── main.html            # Rendered slides
│   ├── references.bib
│   └── figures/
├── code/
│   ├── lab1_experiments.qmd # Lab 1: potential outcomes and randomization
│   ├── lab1_experiments.html
│   ├── lab2_did.qmd         # Lab 2: difference-in-differences
│   └── lab2_did.html
└── data/
    └── google_mobility_data.csv   # County-level mobility data used in Lab 2
```

## Setup

The labs use **R**. Before the workshop, install R and RStudio, then run:

```r
install.packages(c("tidyverse", "fixest", "panelView", "dagitty", "ggdag"))
```

To re-render the slides you'll also need `patchwork`: `cd slides && quarto render main.qmd`

To rebuild the syllabus PDF: `cd syllabi && latexmk -pdf syllabus.tex`

## Further reading

- Nick Huntington-Klein, [*The Effect*](https://theeffectbook.net)
- Scott Cunningham, [*Causal Inference: The Mixtape*](https://mixtape.scunning.com)
- Miguel Hernán & James Robins, [*Causal Inference: What If*](https://miguelhernan.org/whatifbook)
- Alan Gerber & Donald Green, *Field Experiments: Design, Analysis, and Interpretation* (2012)

---

**Zach Dickson**, Fellow in Quantitative Methodology, London School of Economics
