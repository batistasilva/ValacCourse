//valac ReadUInput.vala
//Or valac ReadUInput.vala -o InputData

void main () {
    stdout.printf ("Please enter your name: ");
    string name = stdin.read_line ();
    if (name != null) {
        stdout.printf ("Hello, %s!\n", name);
    }
}
