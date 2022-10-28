// valac -o advancedsample AdvancedSample.vala
public class AdvancedSample : Object {
    public string name { get; set; }   // Property
    public signal void foo ();         // Signal

    public AdvancedSample (string name) {
        this.name = name;
    }

    public void run () {
        // Assigning anonymous function as signal handler
        this.foo.connect ((s) => {
            stdout.printf ("Lambda expression: Argument is %s!\n", this.name);
        });

        // Emitting the signal
        this.foo ();
    }
}

void main (string[] args) {
    foreach (string arg in args) {
        var sample = new AdvancedSample (arg);
        sample.run ();
    }
}
