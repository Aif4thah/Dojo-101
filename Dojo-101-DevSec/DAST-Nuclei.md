# Nuclei pour le test unitaire


## MCO des templates par défaut

* mettre à jour les templates: `.\nuclei.exe -ut`

## tester un seul template

```powershell
.\nuclei.exe -config projet.yml -t .\templates\vla-cwe1104.yaml -l .\urls.txt -duc
```

## Custom templates et workflows

0. Exemple de fichier projet.yaml et urls.txt

```yaml
random-agent: false
rate-limit: 99
bulk-size: 50
concurrency: 20
retries: 2
follow-redirects: true
max-redirects: 1
store-resp: true
verbose: true
severity: critical,high,medium

header:
  - 'User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64)'
```

```txt
https://<site1>
https://<site2>
```

1. définir un workflow

fichier: workflow.yaml

```yaml
id: vla

info:
  name: vla workflow
  author: michael
  description: A simple workflow that runs all vla related nuclei templates on a given target.

workflows:
  - template: C:/Users/<user>/Pro-temp/templates/vla-cwe23.yaml
```

2. créer son template

fichier:  vla-cwe23.yaml

```yaml
id: CWE23

info:
  name: CWE 23 Relative Path Traversal
  author: Michael
  severity: high
  tags: CWE

requests:
  - method: GET
    path:
      - "{{BaseURL}}/?id=../../../../LICENSE.MD"

    matchers-condition: and
    matchers:
      - type: word
        words:
          - "GNU"
          - "LICENSE"
          - "Copyright"
        condition: or

      - type: status
        status:
          - 200
```

3. faire appel à son workflow

```powershell
.\nuclei.exe -config projet.yml -list urls.txt -w .\workflow.yaml -duc -me Result
```

## ne tester que les services Up

[httpx](https://github.com/projectdiscovery/httpx/releases)

```powershell
.\httpx.exe -list urls.txt | .\nuclei.exe -config projet.yml -w .\workflow.yaml -duc
```