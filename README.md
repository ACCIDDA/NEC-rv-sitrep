# Respiratory Virus SitRep (R Markdown site)

## Build locally
In R from the repo root:

```r
rmarkdown::render_site()
```

This will create the site in `docs/`.

## Publish on GitHub Pages (project site)
GitHub repo → Settings → Pages:
- Source: Deploy from a branch
- Branch: main
- Folder: /docs

## Notes
- Commit the entire `docs/` directory after building (it contains `*_files/` dependency folders).
- Logos are referenced from `logos/` and embedded via `knitr::image_uri()`. Make sure `logos/` is committed.
