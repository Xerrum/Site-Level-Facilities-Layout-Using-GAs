# Ant Colony Optimization for Site-Level Facility Layout

MATLAB implementation of an **Ant Colony Optimization (ACO)** algorithm that solves the site-level facility layout problem from Li & Love (1998), a combinatorial and non-linear assignment problem originally solved with a genetic algorithm.

University project (American University in Cairo).

## Problem

Eleven temporary facilities of a construction site (e.g. site office, storage, workshops) have to be assigned to eleven predefined locations. The goal is to minimise the total travel effort between facilities:

$$
f = \sum_{i}\sum_{j>i} F_{ij}\, D_{\pi(i)\pi(j)}
$$

- `F` – frequency matrix: number of trips per day between facility *i* and *j*
- `D` – distance matrix: distance between location *k* and *l*
- `π` – permutation that assigns each facility to a location

Constraints from the paper: **facility 8 is fixed at location 1** and **facility 11 is fixed at location 10**.

The search space has 11! ≈ 40 million layouts, which makes exhaustive search impractical.

## Approach

| Element | Implementation |
|---|---|
| Solution encoding | Each ant builds a permutation (location → facility) |
| Pheromone matrix τ | 11 × 11, `τ(i,j)` = attractiveness of placing facility *j* at location *i* |
| Construction | Roulette-wheel selection over the facilities still available |
| Constraints | Encoded directly in τ (forbidden assignments set to 0, fixed ones forced) |
| Evaporation | `τ ← (1 − ρ)·τ` with ρ = 0.05 |
| Pheromone update | Elitist: only the best ant of each generation deposits `Q / f_best` (Q = 2000) |
| Parameters | 15 ants, 100 generations |

## Files

| File | Content |
|---|---|
| `aco_facility_layout.m` | Main script: initialisation, ant construction, pheromone update, convergence plot |
| `ObjFunAnt.m` | Objective function: total travel effort of a layout (contains `F` and `D`) |

## Usage

```matlab
aco_facility_layout
```

The script plots the best objective value per generation (convergence curve).

## Reference

Li, H. & Love, P. E. D. (1998). *Site-level facilities layout using genetic algorithms.* Journal of Computing in Civil Engineering, 12(4), 227–231.
