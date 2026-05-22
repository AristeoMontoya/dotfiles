; ~/.config/nvim/queries/dockerfile/injections.scm

(run_instruction
  (shell_command
    (shell_fragment) @injection.content)
  (#set! injection.language "bash")
  (#set! injection.priority 250))
