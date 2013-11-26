Coregen files
=============

What are these files for?
-------------------------

This project includes a custom peripheral that contains a FIFO that must
be generated with Coregen before the XPS project can be built.

The .cgp file is a Coregen project file and can be open from CORE Generator.
The .xco file is a description file for the FIFO. You don't need to do
anything with this file.

How to build the netlist in CORE Generator
------------------------------------------

1. Run CORE Generator
2. Select File->Open and browse to this folder (the folder where this
readme file is located).
3. Select the .cgp file.
4. You should see "fifo_generator_v9_3" listed in the "Project IP" list.
Right click on it and select "Regenerate under current project settings".
5. When Coregen has finished generating the netlist, you will find it
in the folder where this readme file is located (it is the .ngc file).

What to do with the netlist file?
---------------------------------

Copy the NGC file into the folder called:
\EDK\pcores\axi_fifo_loopback_v1_00_a\netlist
If the "netlist" folder does not exist, you must create it first.

Now your XPS project should be buildable. Enjoy!


Jeff Johnson
http://www.fpgadeveloper.com
