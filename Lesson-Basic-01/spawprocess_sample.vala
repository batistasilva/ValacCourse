//valac spawprocess_sample.vala
//Or valac spawprocess_sample.vala -o math

void main () {
    try {
        // Non-blocking
        Process.spawn_command_line_async ("ls");

        // Blocking (waits for the process to finish)
        Process.spawn_command_line_sync ("ls");

        // Blocking with output
        string standard_output, standard_error;
        int exit_status;
        Process.spawn_command_line_sync ("ls", out standard_output,
                                               out standard_error,
                                               out exit_status);
    } catch (SpawnError e) {
        stderr.printf ("%s\n", e.message);
    }
}
