//valac --pkg gio-2.0 gio-binary-sample.vala 

int main () {
    try {

        // Reference a BMP image file
        var file = File.new_for_uri ("https://icn.lycee-valin.fr/projets2017/seconde13/eleve13/images/imaget.bmp");
//      var file = File.new_for_path ("sample.bmp");

        // Open file for reading
        var file_stream = file.read ();
        var data_stream = new DataInputStream (file_stream);
        data_stream.set_byte_order (DataStreamByteOrder.LITTLE_ENDIAN);

        // Read the signature
        uint16 signature = data_stream.read_uint16 ();
        if (signature != 0x4d42) {   // this hex code means "BM"
            stderr.printf ("Error: %s is not a valid BMP file\n", file.get_basename ());
            return 1;
        }

        data_stream.skip (8);        // skip uninteresting data fields
        uint32 image_data_offset = data_stream.read_uint32 ();

        data_stream.skip (4);
        uint32 width = data_stream.read_uint32 ();
        uint32 height = data_stream.read_uint32 ();

        data_stream.skip (8);
        uint32 image_data_size = data_stream.read_uint32 ();

        // Seek and read the image data chunk
        uint8[] buffer = new uint8[image_data_size];
        file_stream.seek (image_data_offset, SeekType.CUR);
        data_stream.read (buffer);

        // Show information
        stdout.printf ("Width: %ld px\n", width);
        stdout.printf ("Height: %ld px\n", height);
        stdout.printf ("Image data size: %ld bytes\n", image_data_size);

    } catch (Error e) {
        stderr.printf ("Error: %s\n", e.message);
        return 1;
    }

    return 0;
}
