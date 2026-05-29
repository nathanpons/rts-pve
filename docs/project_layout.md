# Project Layout

## Menu Workflow

```mermaid
graph TD
A[Main Menu] --> B[Level Select] & C[Upgrades Page]
C --> A
B --> D[Level 1] & A
D --> B
D --> E[Faction Select]
E --> D
E --> G[Gameplay]
G --> A

```
