//valac readwrite_sample.vala
//Or valac readwrite_sample.vala -o math

void main () {
    try {
        string filename = "data.txt";

        // Writing
        string content = "hello, world";
        FileUtils.set_contents (filename, content);

        // Reading
        string read;
        FileUtils.get_contents (filename, out read);

        stdout.printf ("The content of file '%s' is:\n%s\n", filename, read);
    } catch (FileError e) {
        stderr.printf ("%s\n", e.message);
    }
}
