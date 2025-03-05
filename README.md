# ECEC Model

[![CI](https://github.com/cormas/ecec-model/actions/workflows/test.yml/badge.svg)](https://github.com/cormas/ecec-model/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/cormas/ecec-model/badge.svg?branch=main)](https://coveralls.io/github/cormas/ecec-model?branch=main)
[![Pharo version](https://img.shields.io/badge/Pharo-v9.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-v10.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-v11.0-%23aac9ff.svg)](https://pharo.org/download)
[![Cormas version](https://img.shields.io/badge/Cormas-dev-green?logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA8AAAAPCAMAAAAMCGV4AAABSlBMVEUAAAAOp0PDL3IGo0EDo0Int1XABWwAokAao0YVo0bNA3EFokIAoT8Lo0QOpEXALXAJqkYVo0c6tFsQpkYIqUiFHVhIs2AVoUhR8nkpmEQnj0LIAG9BeUeYRF27HWoDkUEPnkGJSFoFo0Ijo0gRmUIEokIdm0EHokFGckbDIW/FK3EMmEMApEJ+TFhqYFAWo0UAo0ExgkMNokO4GWsDo0ErpEwQpkLMDHQxdkUgikIopErKAHEIo0ICoUIAp0SrLGYCkUJlW04ra0MLo0U/p1ieLV7DPHUAq1QEgFC6AG0oWEBeAEwuuVHMAGYCuUoOsUjZI3rNDnPHA28Pv04MuUsBr0UBqUPaHnrZGHnPGXW6SXDIIXDAL2+0QGu4NGuhTWR2ZlZ4XlVjdlJocFJoaVAaukxHjUwXs0oFs0kbrEg6jEgUqUcYnUYUpEI1naPBAAAATnRSTlMABFZwUwf85dfFtY2HcmZcPDAuKCMiIB4J+vbx7evn49/d3dvY1tTTx8PAvr68ubm0sK+snpSSkZGOhoOAgHxzbWJfWVFPSEZAPyAbFgqRz/lQAAAAxUlEQVQI1zXOw5IDYQBF4fM3Ynts27bVHc9MbOf9t6l0Kl/VXZzdxaA4HLKfscCKpncTh6ijVBdbl6GI7xsEw8naCTyeXygCw3Y7EJzJFEuNecXotcngbOxsyrTT0Z0Aq9NHf27cv1fvEykPgq1afJMfNrK8NfeB+2pcAqToC0tmnHtiPW+TXiVb7gGLGXvCx24h+h8zlT9D+jHhtBW+Pu4WKgcRS9oP15r12XM711vmSXMB2FPJZL1/qiK8GLzyjSs8es8AWmUcev/cGYQAAAAASUVORK5CYII=)](https://github.com/cormas/cormas)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/cormas/ecec-model/master/LICENSE)

The model we present here is inspired from a paper by Pepper and Smuts, "Evolution of Cooperation in an Ecological Context":

> Pepper, J.W. and B.B. Smuts. 2000. "The evolution of cooperation in an ecological context: an agent-based model". Pp. 45-76 in T.A. Kohler and G.J. Gumerman, eds. Dynamics of human and primate societies: agent-based modeling of social and spatial processes. Oxford University Press, Oxford.


> Pepper, J.W. and B.B. Smuts. 2002. "Assortment through Environmental Feedback". American Naturalist, 160: 205-213


The model consists of a two-dimensional grid, wrapped in both axes to avoid edge effects. It contains two kinds of entities: plants and foragers. The main idea is the study of the survival of two populations of agents that depends on the spatial configuration. 
The Plants are created only once and have a fixed location. They do not move, die, or reproduce. A plant’s only “behaviors” is to grow (and be eaten by foragers). The plants vary only in their biomass, which represents the amount of food energy available to foragers. At each time unit, this biomass level increases according to a logistic growth:



* Biomass(t+1) = Biomass(t) + r.Biomass(t) . [1 - Biomass(t) / K]

Each step, the Foragers burn energy according to their catabolic rate. This rate is the same for all foragers. It is fixed to 2 units of energy per time period.
A forager feeds on the plant in its current location if there is one. It increases its own energy level by reducing the same amount of the plant. Foragers are of two types that differs in their feeding behavior:
When “Restrained” foragers eat, they take only 50% of the plant’s energy. 
In contrast, “Unrestrained” foragers eat 99% of the plant. This harvest rate is less than 100% so that plants can continue to grow after being fed on, rather than being permanently destroyed.
The Foragers do not change their feeding behavior type and their offspring keep the same heritable traits.

Foragers examine their current location and around. From those not occupied by another forager, they choose the one containing the plant with the highest energy.
If the chosen plant would yield enough food to meet their catabolic rate they move there. If not, they move instead to a randomly chosen adjacent free place (not occupied by another forager). This movement rule leads to the emigration of foragers from depleted patches, and simulates the behavior of individuals exploiting local food sources while they last, but migrating rather than starving in an inadequate food patch. 

Foragers loose energy (catabolic rate, 2 points) regardless of whether or not they move.
If their energy level reaches zero, they die. But they do not have maximum life spans. 
If a forager’s energy level reaches an upper fertility threshold (fixed to 100), it reproduces asexually, creating an offspring with the same heritable traits as itself (e.g., feeding strategy). At the same time the parent’s energy level is reduced by the offspring’s initial energy (50).  
Newborn offspring occupy the nearest free place to their parent. 



ECEC Model implemented using Cormas platform

```st
Metacello new
    repository: 'github://cormas/ecec-model:main';
    baseline: 'ECECModel';
    load.
```
