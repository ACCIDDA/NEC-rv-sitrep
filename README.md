**When updating:**
<br>
For the webpage to reflect changes made, you will need to re-render the website each time before pushing to the repo. 
<br>
Run: `rmarkdown::clean_site(preview = FALSE)` then `rmarkdown::render_site()` from the repo root.
<br>
If you want to edit a page of the website, edit the corresponding RMD file in the '_sections' folder.

<br><br>
**Automation:**
<br>
This repository includes a GitHub Actions workflow at `.github/workflows/render-site.yml` that:
- runs weekly,
- can be run on demand from the Actions tab, and
- commits rendered updates only when `docs/` changes.
