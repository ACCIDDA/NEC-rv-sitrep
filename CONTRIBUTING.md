# Contributing to NEC Respiratory Virus Situation Report

Thank you for contributing to this project! This guide provides detailed information on how to work with this R Markdown website.

## Understanding the Workflow

### The Build Process

This is an **R Markdown website** that uses a source-to-HTML build process:

```
Source Files (_sections/*.Rmd)
        ↓
   [render_site()]
        ↓
HTML Output (docs/*.html)
        ↓
  GitHub Pages serves the website
```

### File Organization

```
Repository Root
├── _sections/          ← EDIT THESE FILES
│   ├── _home.Rmd
│   ├── hospital.Rmd
│   └── ...
├── index.Rmd          ← Template (includes _sections/_home.Rmd)
├── hospital.Rmd       ← Template (includes _sections/hospital.Rmd)
├── _site.yml          ← Site configuration
└── docs/              ← GENERATED HTML (don't edit manually)
    ├── index.html
    └── ...
```

## Making Changes

### 1. Setup Your Environment

Install required R packages:

```r
install.packages(c("rmarkdown", "knitr"))
# Install any other packages used in the analysis
```

### 2. Edit Content

**To update a page:**
- Find the corresponding file in `_sections/`
- Edit the R Markdown content
- Save the file

**Examples:**
- Update home page → edit `_sections/_home.Rmd`
- Update hospital data visualization → edit `_sections/hospital.Rmd`
- Update data fetching logic → edit `_sections/_pull_data.Rmd`
- Update common setup (libraries, functions) → edit `_sections/_setup.Rmd`

### 3. Render the Site

**From R Console:**
```r
# Make sure you're in the repository root directory
setwd("/path/to/NEC-rv-sitrep")

# Render the entire site
rmarkdown::render_site()
```

**What this does:**
1. Processes each root `.Rmd` file (index.Rmd, hospital.Rmd, etc.)
2. Evaluates all R code chunks
3. Generates visualizations and tables
4. Creates corresponding HTML files in `docs/`
5. Copies assets (CSS, images) to `docs/`

**Troubleshooting:**
- If you get package errors, install the missing packages
- If you get data errors, check your internet connection (for data APIs)
- Check the R console for specific error messages

### 4. Preview Locally

Open any HTML file in `docs/` with your web browser:
- `docs/index.html` - Home page
- `docs/hospital.html` - Hospital admissions page
- etc.

Check that:
- Content renders correctly
- Visualizations display properly
- Links work
- Styling is correct

### 5. Commit and Push

```bash
# Check what changed
git status

# Stage your changes
git add _sections/
git add docs/

# Commit with a descriptive message
git commit -m "Update hospital admissions visualization"

# Push to GitHub
git push
```

**Important:** You must commit both:
- Source files in `_sections/`
- Generated HTML in `docs/`

GitHub Pages serves from `docs/`, so if you don't commit the HTML, the website won't update.

## Common Tasks

### Adding a New Page

1. Create content file in `_sections/new-page.Rmd`
2. Create root template `new-page.Rmd`:
   ```r
   ---
   output:
     html_document:
       theme:
         version: 5
         bootswatch: flatly
   ---
   
   ```{r child = '_sections/_setup.Rmd'}
   ```
   ```{r child = '_sections/new-page.Rmd'}
   ```
   ```{r child = '_sections/_logos.Rmd'}
   ```
   ```
3. Add to navigation in `_site.yml`
4. Render the site
5. Commit and push

### Updating Styles

1. Edit `styles.css`
2. Render the site (to copy CSS to `docs/`)
3. Commit and push

### Changing Site Configuration

1. Edit `_site.yml`
2. Render the site
3. Commit and push

## Best Practices

- **Test before pushing:** Always render and preview locally first
- **Small commits:** Make focused changes and commit frequently
- **Descriptive messages:** Write clear commit messages explaining what changed
- **Don't skip rendering:** The site won't update without re-rendering
- **Keep _sections/ organized:** All content should be in `_sections/`, not root `.Rmd` files

## Questions?

If you're unsure about something:
1. Check this guide and the README
2. Look at existing files as examples
3. Open an issue to ask for help
