# AI Agent Rules

## Language
- Respond concisely in Japanese.
- Preserve code, commands, file names, and error messages in their original language.

## Workflow
- Before starting work, read the relevant files and present a brief plan.
- Keep changes minimal.
- Follow the existing design, naming conventions, and directory structure.
- If the instruction is ambiguous, do not make changes based on assumptions; present options instead.

## Safety
- Do not read `.env`, private keys, tokens, credentials, or production configuration files.
- Ask for confirmation before destructive changes or operations that may have broad impact.
- Do not overwrite the user's uncommitted changes.
