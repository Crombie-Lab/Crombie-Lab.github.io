# AGENTS.md — Crombie Lab Website

## Scope and mission

This repository hosts the public Crombie Lab website using Jekyll and the al-folio academic website theme. Your job is to make accurate, targeted website changes while preserving the existing layout, navigation, URLs, and GitHub Pages publishing workflow unless the user specifically requests a change to them.

Use this file as project guidance, not as a substitute for Codex sandbox permissions or AI-Panther's cluster policies.

## Repository orientation

Before editing, inspect `README.md`, `_config.yml`, `Gemfile`, `.github/workflows/`, and the relevant existing page and collection files. Do not assume the theme's defaults match this fork.

Likely content locations (verify before changing):

- `_pages/about.md` — homepage / lab introduction.
- `_pages/projects.md` — research-project listing and navigation metadata.
- `_projects/*.md` — individual research project content and YAML front matter.
- `assets/img/` — images; use only appropriately licensed or lab-owned material.
- `_includes/`, `_layouts/`, `_sass/` — templates and presentation; edit only when necessary.
- `_config.yml`, `Gemfile`, `.github/workflows/` — infrastructure; do not change without explicit permission.

Preserve front matter, Liquid/Jekyll syntax, existing permalink conventions, and site-relative asset paths. Follow patterns already present in the repository. Keep changes minimal and readable.

## Research information architecture

Present three primary research programs:

1. **Natural Genetic Variation in Pesticide Susceptibility**
   - Chlorfenapyr resistance and chromosome V QTL fine-mapping.
   - Pyrethroid susceptibility and quantitative behavioral assays.
   - Behavioral responses to neurotoxicants; future mixture experiments testing additivity, synergy, and antagonism, potentially followed by genetic mapping of interaction modifiers.
2. **Natural Diversity and Ecology of Florida Caenorhabditis**
   - Florida field collection, species identification, population diversity, ecological metadata, and the developing `ecoLinkR` software workflow.
3. **Natural Genetic Modifiers of Neurodegenerative Disease**
   - Natural-background differences in MPP+-associated dopaminergic behavioral responses and human-tau-associated phenotypes; automated C. elegans phenotyping and neuronal imaging.

These descriptions are editorial guidance, not evidence for particular findings or funding outcomes. Do not invent experimental results, publications, grant awards, software releases, images, collaborators, or citations. Distinguish published results, preliminary work, active experiments, and future plans. The R15 and R03 labels describe grant projects; do not represent either award as funded without confirmation.

## Scientific and editorial style

- Write clear, concise, accurate descriptions for prospective students, researchers, and a general scientifically interested audience.
- Prefer precise terminology and avoid exaggerated claims of causality, clinical relevance, resistance mechanisms, or application.
- Italicize scientific genus/species names in rendered Markdown (e.g., `*Caenorhabditis elegans*` or `*C. elegans*`); do not italicize gene symbols by default unless scientifically appropriate.
- Spell pesticide names consistently: chlorfenapyr, permethrin, deltamethrin, and lambda-cyhalothrin.
- Distinguish chemical combination effects from proven synergy; do not call an interaction synergistic without an explicit quantitative model.
- Keep titles in title case unless the site convention requires otherwise.
- No placeholder content, demo cards, stock photos, or external redirects on finished research pages.
- Do not publish sensitive or unpublished lab information, internal paths, credentials, personal information, or grant-review materials without explicit direction.

## Editing workflow

1. Inspect `git status --short`, current branch, and existing pages before changing files. If the worktree contains unrelated changes, preserve them and report possible conflicts.
2. Give a brief plan for multi-file edits. Work only on the requested website task.
3. Reuse current Jekyll components and page conventions; avoid introducing new dependencies for content-only changes.
4. Maintain stable URLs when practical. If replacing demonstration project files, check whether any existing internal links reference them.
5. Do not modify unrelated files, generated output, Git history, or existing scientific claims not part of the request.
6. If multiple agents work concurrently, assign non-overlapping files; do not make competing edits to shared configuration or page templates.
7. Do not run `git commit`, `git push`, `git reset --hard`, `git clean -fd`, merges, rebases, or deployments unless the user explicitly authorizes the specific action. Prepare and report changes for human review.

## Validation and reporting

- Run `git diff --check` and review `git diff` for unexpected changes.
- Check YAML front matter, project ordering, navigation, internal links, and image references.
- If Ruby/Bundler and required gems are already installed, use `bundle check`, then (where cluster policy permits) `bundle exec jekyll build` to validate the site.
- If dependencies are absent, report what is missing; ask before installing packages or accessing the network.
- If a local build is infeasible, perform static checks and explain what was not tested.
- End with a concise summary of changed files, tests run and their outcomes, and any remaining publication steps. Do not claim a site is deployed merely because local checks pass.

## AI-Panther and security boundaries

- This is a shared HPC system. Use the login node for lightweight editing/inspection only. Use an approved Slurm allocation or interactive development session for substantial builds, installs, or other resource-intensive work, following local cluster policy.
- Never submit Slurm jobs, allocate GPUs, start persistent background processes, install system packages, or change shared HPC settings without explicit instruction.
- Stay within this Git repository for task files. Do not access other lab projects, mounted NAS data, SSH keys, token stores, cluster credentials, or another user's files.
- Never run privileged commands (`sudo`), pipe internet scripts into a shell, disable security features, or bypass the Codex sandbox.
- Do not modify Codex sandbox configuration, GitHub Actions, Git remotes, secrets, or access permissions unless specifically requested.
- Use minimal commands and respect HPC resource limits; do not assume local Docker, root access, or outbound network access.

## Publication boundary

GitHub Pages may deploy automatically after changes reach the configured publishing branch. Treat commits, pushes, pull-request merges, and workflow dispatches as publication-adjacent actions requiring explicit user approval. A completed task is a reviewed local patch plus a verification report unless the user directs otherwise.
