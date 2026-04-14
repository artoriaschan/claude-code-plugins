# Project Overview

## What Is This Project

A personal plugin management project for Claude Code. It hosts custom plugins that extend Claude Code's capabilities for development workflows.

## Goals

1. **Reusable plugins**: Build plugins for recurring development tasks (CLI scaffolding, code review, deployment, etc.)
2. **Personal conventions**: Enforce consistent code styles and project structures across all generated projects
3. **Iterative improvement**: Plugins evolve based on daily usage — new skills and agents are added as needs arise

## Design Principles

### Per-Plugin Independence

Each plugin lives under `plugins/<name>/` with its own manifest. Plugins are independently developable, testable, and shareable.

### Auto-Discovery Over Explicit Registration

Skills, agents, and hooks are auto-discovered from standard directories. Manifest paths override auto-discovery only when needed.

### Fail-Graceful Hooks

All hooks use `|| true` to prevent blocking AI work. Hooks assist, never obstruct.

### Convention as Code

Coding conventions from the `coding-plans-statusline` project are captured as rules and enforced automatically — not documented and forgotten.

## Future Plans

- Add more plugins as development needs arise
- Potentially publish plugins to the Claude Code marketplace
