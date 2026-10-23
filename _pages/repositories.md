---
layout: page
permalink: /repositories/
title: resources
description: Software, reproducible research materials, and community tools.
nav: true
nav_order: 5
---

<div class="resources-page">
  <p>Explore software, reproducible research materials, and community resources developed or used by the Crombie Lab.</p>

  <h2>Research resources</h2>

  <div class="resource-links">
    <a class="resource-card" href="https://caendr.org/">
      <span class="resource-card-label">Community data and analysis</span>
      <h3>CaeNDR</h3>
      <p>
        The <em>Caenorhabditis</em> Natural Diversity Resource provides wild-strain, genome, and variation data and tools for
        quantitative and population genetics.
      </p>
      <span class="resource-card-link">Visit CaeNDR <i class="fa-solid fa-arrow-up-right-from-square fa-xs"></i></span>
    </a>

    <a class="resource-card" href="https://github.com/Crombie-Lab">
      <span class="resource-card-label">Code and data</span>
      <h3>Crombie Lab on GitHub</h3>
      <p>Browse all public lab software, analysis workflows, teaching materials, and reproducible research repositories.</p>
      <span class="resource-card-link">View the organization <i class="fa-solid fa-arrow-up-right-from-square fa-xs"></i></span>
    </a>

  </div>

  <h2>Featured lab repositories</h2>

  <p>Selected software and reproducible research materials hosted by the Crombie Lab.</p>

{% if site.data.repositories.github_repos %}

<div class="repositories d-flex flex-wrap flex-md-row flex-column justify-content-between align-items-center">
{% for repo in site.data.repositories.github_repos %}
{% include repository/repo.liquid repository=repo %}
{% endfor %}
</div>
{% endif %}

</div>
