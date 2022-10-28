public class BasicSample : Object {

    public void run () {
        stdout.printf ("Hello World for Class2\n");
    }

    static int main (string[] args) {
        var sample = new BasicSample ();
        sample.run ();
        return 0;
    }
}
