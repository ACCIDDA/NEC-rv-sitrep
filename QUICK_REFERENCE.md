# Quick Reference: Updating the Website

## TL;DR

```bash
# 1. Edit files in _sections/
# 2. Render the site
Rscript -e "rmarkdown::render_site()"
# 3. Commit and push
git add .
git commit -m "Update content"
git push
```

## What the README Note Means

The original note in the README was explaining that this is an **R Markdown website** that requires a **build step**:

### The Key Concept

**Source files** (`.Rmd` in `_sections/`) → **Build** (`render_site()`) → **Output** (`.html` in `docs/`) → **Website**

You can't just edit HTML files and push them. You must:
1. Edit the R Markdown source files
2. Run the build command to regenerate HTML
3. Commit both source and generated files

### Why This Matters

- **GitHub Pages** serves static HTML from the `docs/` folder
- **R Markdown** files need to be processed to become HTML
- **Skipping the render step** means your changes won't appear on the website

### File Mapping

| To update this page... | Edit this file...           | Which generates...     |
|------------------------|----------------------------|------------------------|
| Home page              | `_sections/_home.Rmd`      | `docs/index.html`      |
| Hospital Admissions    | `_sections/hospital.Rmd`   | `docs/hospital.html`   |
| ED Visits              | `_sections/ed_visits.Rmd`  | `docs/ed_visits.html`  |
| Trajectory Maps        | `_sections/trajectory-maps.Rmd` | `docs/trajectory-maps.html` |
| Vaccination            | `_sections/vaccination.Rmd` | `docs/vaccination.html` |
| About                  | `_sections/about.Rmd`      | `docs/about.html`      |

### Common Questions

**Q: Why can't I just edit the HTML in `docs/`?**  
A: Changes would be lost the next time someone runs `render_site()`. Always edit the source `.Rmd` files.

**Q: Why are there two `hospital.Rmd` files?**  
A: The root `hospital.Rmd` is a template that includes `_sections/hospital.Rmd`. Edit the one in `_sections/`.

**Q: What does `rmarkdown::render_site()` do?**  
A: It processes all `.Rmd` files, runs R code, generates plots, and creates HTML files in `docs/`.

**Q: Do I need to commit the `docs/` folder?**  
A: Yes! GitHub Pages serves from `docs/`, so you must commit the generated HTML.

**Q: Can I just use `git push`?**  
A: Not until you've run `render_site()`. The workflow is: edit → render → commit → push.

## From the Command Line

```bash
# Render from command line (instead of R console)
Rscript -e "rmarkdown::render_site()"

# Or using R's CLI
R -e "rmarkdown::render_site()"
```

## Rendering Individual Pages

```r
# Render just one page (faster for testing)
rmarkdown::render("hospital.Rmd")

# But always render the full site before pushing
rmarkdown::render_site()
```
