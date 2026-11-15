# Victor Baez - Cloud Resume

A single-page resume hosted on Azure Static Web Apps and deployed by GitHub Actions.

## Layout

| Path | Purpose |
|---|---|
| `index.html`, `style.css`, `favicon.svg` | The site. No build step, no JavaScript. |
| `404.html` | Custom not-found page. |
| `staticwebapp.config.json` | Security headers, the 404 override, and rules that keep repo-only files off the public site. |
| `infra/main.bicep` | Bicep definition of the Static Web App. Reference only, not run by CI. |
| `.github/workflows/` | Static Web Apps CI/CD: deploys on push to `main`, builds a preview environment per pull request. |

## Deploy

Push to `main`. The workflow uploads the repo root to the Static Web App using the deployment token stored in the repo secrets.

## Preview locally

```
python -m http.server 8000
```

Then open http://localhost:8000. The headers and 404 rule in `staticwebapp.config.json` only apply on Azure (or under the Static Web Apps CLI).

## Recreate the hosting

```
az deployment group create -g <resource-group> -f infra/main.bicep -p staticWebAppName=<name>
```
