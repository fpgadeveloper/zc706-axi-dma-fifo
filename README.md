zc706-axi-dma-fifo
==================

Example project that uses the AXI DMA peripheral to connect a custom AXI-Stream peripheral to memory

### Description

This type of design is typical for applications where there is a data source that constantly generates
data (for example, an ADC) and we wish to store this data in a memory mapped storage device (for example
SDRAM). The design can also be used for the reverse case, where we have data in memory and we would like
to send that data as a stream to some external device (for example a DAC).

The AXI DMA peripheral allows us to feed in an AXI-Stream, and have that data transferred to a
specific address on the memory map. It also allows us to do the reverse, which is to transfer data from
a specific address to an AXI stream. The processor determines the address to store the data or the
address of the data to send.

The custom AXI-Stream peripheral has one master and one slave AXI-Stream port and contains an AXI-Stream
FIFO. The data pushed into the slave interface can then be read out of the master interface.

### Requirements

* ISE Design Suite 14.7
* ZC706 Evaluation Board

### License

Feel free to modify the custom AXI-Stream peripheral for your specific application.

### Fork and share

If you port this project to another hardware platform, please send me the
code or push it onto GitHub and send me the link so I can post it on my
website. The more people that benefit, the better.

### About the author

I'm an FPGA consultant and I provide FPGA design services and training to
innovative companies around the world. I believe in sharing knowledge and
I regularly contribute to the open source community.

Jeff Johnson
http://www.fpgadeveloper.com