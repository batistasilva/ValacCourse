// valac --pkg gio-2.0 gio-file-operations.vala

int main () {
    try {

        // Reference a local file name
        var file = File.new_for_path ("samplefile.txt");

        {
            // Create a new file with this name
            var file_stream = file.create (FileCreateFlags.NONE);

            // Test for the existence of file
            if (file.query_exists ()) {
                stdout.printf ("File successfully created.\n");
            }

            // Write text data to file
            var data_stream = new DataOutputStream (file_stream);
            data_stream.put_string ("Hello, world");
        } // Streams closed at this point

        // Determine the size of file as well as other attributes
        var file_info = file.query_info ("*", FileQueryInfoFlags.NONE);
        stdout.printf ("File size: %lld bytes\n", file_info.get_size ());
        stdout.printf ("Content type: %s\n", file_info.get_content_type ());

        // Make a copy of file
        var destination = File.new_for_path ("samplefile.bak");
        file.copy (destination, FileCopyFlags.NONE);

        // Delete copy
        destination.delete ();

        // Rename file
        var renamed = file.set_display_name ("samplefile.data");

        // Move file to trash
        renamed.trash ();

        stdout.printf ("Everything cleaned up.\n");

    } catch (Error e) {
        stderr.printf ("Error: %s\n", e.message);
        return 1;
    }

   return 0;
}
