/* class derived from GObject */
public class BasicSample : Object {

    /* public instance method */
    public void run () {
        stdout.printf ("Hello World for First Class\n");
    }
}

/* application entry point */
int main (string[] args) {
    // instantiate this class, assigning the instance to
    // a type-inferred variable
    var sample = new BasicSample ();
    // call the run method
    sample.run ();
    // return from this main method
    return 0;
}
