# NEC Respiratory Virus Situation Report

This repository contains an R Markdown website that displays respiratory virus surveillance data for Arizona, Colorado, New Mexico, and Utah. The website is published via GitHub Pages at https://accidda.github.io/NEC-rv-sitrep/.

## Repository Structure

- **`_sections/`** - Content files that should be edited when updating the website
  - `_home.Rmd` - Home page content
  - `_setup.Rmd` - Common setup code and libraries
  - `_pull_data.Rmd` - Data fetching logic
  - `hospital.Rmd`, `ed_visits.Rmd`, `vaccination.Rmd`, `trajectory-maps.Rmd` - Page-specific content
  - `_logos.Rmd` - Footer logos
  
- **Root `.Rmd` files** - Page templates that include sections via `child` chunks
  - `index.Rmd`, `hospital.Rmd`, `ed_visits.Rmd`, etc.
  - These files generally should NOT be edited directly
  
- **`docs/`** - Generated HTML files served by GitHub Pages
  - Auto-generated from `.Rmd` files
  - Should NOT be edited manually
  
- **`_site.yml`** - Website configuration (navigation, theme, output settings)

## How to Update the Website

### Prerequisites

- R (>= 4.0)
- RStudio (recommended)
- Required R packages: `rmarkdown`, `knitr`, and any packages used in the analysis

### Workflow

1. **Edit content files** in the `_sections/` folder
   - For example, to update the hospital admissions page, edit `_sections/hospital.Rmd`
   - To change the home page, edit `_sections/_home.Rmd`

2. **Re-render the entire website** before committing changes:
   ```r
   # Run this from the R console in the repository root directory
   rmarkdown::render_site()
   ```
   
   This command:
   - Processes all `.Rmd` files in the root directory
   - Executes R code chunks and generates plots
   - Creates HTML files in the `docs/` folder
   - Applies styling and navigation from `_site.yml`

3. **Commit and push** both your source changes and the generated HTML:
   ```bash
   git add _sections/
   git add docs/
   git commit -m "Update [description of changes]"
   git push
   ```

4. **GitHub Pages** will automatically serve the updated site from the `docs/` folder

### Important Notes

- **Always re-render before pushing** - The website won't update unless you regenerate the HTML files in `docs/`
- **Don't edit HTML directly** - Changes to files in `docs/` will be overwritten the next time the site is rendered
- **Edit `_sections/`, not root `.Rmd`** - The root `.Rmd` files are just templates that include content from `_sections/`
- **Test locally** - You can open the HTML files in `docs/` with a web browser to preview changes before pushing

## Configuration

- **Site settings**: Edit `_site.yml` to change navigation, theme, or output options
- **Styling**: Edit `styles.css` for custom CSS
- **Parameters**: Each page has parameters (states, diseases, date ranges) defined in its YAML header
