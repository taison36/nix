---
name: herdr-agent-coordination
description: Use Herdr to create tabs, start coding agents in them, hand off prompts, and track their progress. Use when coordinating independent agents across Herdr tabs or panes.
---

# Herdr Agent Coordination

Use this skill when the user asks you to delegate work to a separate agent running in a Herdr tab or pane. These are independent agent sessions, not Codex subagents.

## Check Herdr access

Before controlling a Herdr session, check that `HERDR_ENV=1` is set in your environment and that `herdr agent list` works. If not, explain that this agent is not running in a Herdr-managed pane or cannot reach its Herdr server. Do not guess IDs or try to control another local or remote session. Herdr IDs belong to one server; use `herdr --machine NAME ...` only when the user clearly identified that saved machine.

Use Herdr's `agent` commands for recognized coding agents, and `workspace`, `tab`, and `pane` commands for terminal layout. An agent in another tab can be targeted by its unique live name when both tabs use the same Herdr server. `agent start` starts an agent in an existing shell pane; it does not create a tab or pane.

## Reuse or create a destination

First inspect `herdr agent list`, `herdr workspace list`, and, as needed, `herdr tab list` or `herdr pane list`. Reuse the user's intended live agent or an explicitly requested existing shell pane when possible. Do not send work to an unrelated agent just because it is available.

If a new tab is requested, create it in the intended workspace and repository directory. Use the workspace ID when known:

```sh
created=$(herdr tab create --workspace WORKSPACE_ID --cwd /path/to/repo --label task-name --no-focus)
pane_id=$(printf '%s\n' "$created" | jq -r '.result.root_pane.pane_id')
```

Without `--workspace`, Herdr uses the active workspace and fails if there is none. `--cwd` sets the tab's directory; it does not create an isolated worktree. If the user needs file isolation, create or choose a separate worktree first, then use its path as `--cwd`.

Use returned IDs only. `tab create` creates a shell pane but does not start an agent. `--no-focus` preserves the user's current focus.

## Start the agent and hand off work

Choose an unused short agent name matching `[a-z][a-z0-9_-]{0,31}`. Start the requested supported agent in the returned pane, for example:

```sh
herdr agent start api-review --kind codex --pane "$pane_id"
```

Then submit one clear prompt with the concrete task, repository or worktree path, constraints, acceptance criteria, and what to report back. Preserve the user's actual instructions and do not invent extra work. For example:

```sh
herdr agent prompt api-review "Review the changes in /path/to/repo for the reported bug. Do not edit files. Return findings with file and line references." --wait --timeout 300000
```

`agent prompt --wait` waits for the task to settle, accepting `idle`, `done`, or `blocked` by default. It can also prompt an agent that is already working. A timeout or `agent_prompt_stalled` does not prove the prompt was not sent: read the agent before retrying to avoid duplicating work.

## Track and collect results

Use `herdr agent get NAME`, `herdr agent wait NAME`, and `herdr agent read NAME --source recent-unwrapped --lines 120` to check progress and collect the response. Treat `unknown` as uncertain, not as success. If the agent is `blocked`, inspect its output first; use `herdr agent send-keys` only to answer a visible, understood dialog. Never send blind Enter or approval keystrokes.

Tell the user which agent and tab you created, the task handed off, and the observed status/result. Do not claim completion based only on a successful prompt submission.

Herdr command approval and sandbox rules still apply. Do not bypass them with alternate shells, raw pane input, or permissive launch flags.

For changed CLI details, consult the [Herdr CLI reference](https://herdr.dev/docs/cli-reference/) and [agent automation guide](https://herdr.dev/docs/agent-automation/).
