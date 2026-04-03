# codex-skills

Single source of truth for custom Codex skills shared across Mac and Windows.

## Structure

- `skills/`: your custom skills (`<skill-name>/SKILL.md`)
- `scripts/link_skills_mac.sh`: link repo skills into `~/.codex/skills`
- `scripts/link_skills_windows.ps1`: link repo skills into `%USERPROFILE%\\.codex\\skills`

## Mac

```bash
bash scripts/link_skills_mac.sh
```

## Windows (PowerShell)

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\link_skills_windows.ps1
```

## Daily workflow

1. `git pull`
2. edit/create skills under `skills/`
3. run link script once
4. test in Codex
5. `git add . && git commit -m "..." && git push`
