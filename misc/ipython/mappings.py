from IPython import get_ipython
from prompt_toolkit.enums import DEFAULT_BUFFER
from prompt_toolkit.filters import HasFocus, HasSelection, ViInsertMode
from prompt_toolkit.key_binding.vi_state import InputMode

ip = get_ipython()


def switch_mode(event):
    vi_state = event.cli.vi_state
    vi_state.input_mode = InputMode.NAVIGATION


# Register the shortcut if IPython is using prompt_toolkit
if hasattr(ip, "pt_app") and ip.pt_app:
    insert_mode = ViInsertMode()

    registry = ip.pt_app.key_bindings
    # Map 'kj' to Escape.
    registry.add_binding(
        "k", "j", filter=(HasFocus(DEFAULT_BUFFER) & ~HasSelection() & insert_mode)
    )(switch_mode)

    # Add back standard readline-like mappings, even when using ViInsertMode
    from prompt_toolkit.key_binding.bindings.named_commands import get_by_name

    handle = registry.add
    handle("c-a")(get_by_name("beginning-of-line"))
    handle("c-b")(get_by_name("backward-char"))
    handle("c-e")(get_by_name("end-of-line"))
    handle("c-f")(get_by_name("forward-char"))
    handle("c-left")(get_by_name("backward-word"))
    handle("c-right")(get_by_name("forward-word"))
    handle("escape", "b")(get_by_name("backward-word"))
    handle("escape", "c", filter=insert_mode)(get_by_name("capitalize-word"))
    handle("escape", "d", filter=insert_mode)(get_by_name("kill-word"))
    handle("escape", "f")(get_by_name("forward-word"))
    handle("escape", "l", filter=insert_mode)(get_by_name("downcase-word"))
    handle("escape", "u", filter=insert_mode)(get_by_name("uppercase-word"))
    handle("escape", "y", filter=insert_mode)(get_by_name("yank-pop"))
    handle("escape", "backspace", filter=insert_mode)(get_by_name("backward-kill-word"))
    handle("escape", "\\", filter=insert_mode)(get_by_name("delete-horizontal-space"))
