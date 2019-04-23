# MSX Disk ROM

This is the source code of the MSX Disk ROM. This code provides an implementation to access the floppy disk in a MSX system.

## Architecture

The MSX Disk ROM is architectured in two layers:

- The topmost layer is the MSX Disk BIOS. This is the layer that exposes a high-level API to the applications, the MSX Basic and the MSX-DOS to gain access to the floppy drive. This code is generic, (supposedly) implemented by ASCII Corporation and licensed to the hardware vendors to integrate it in their ROMs. The source code of different versions of MSX Disk BIOS can be found in [bios/ subdirectory](./bios/).
- The bottommost layer is the MSX Disk Driver. This is a layer that exposes a low-level API to the MSX Disk BIOS. This code is vendor-specific, since it provides a suitable implementation specific to each hardware interface. The source code of different drivers can be found in [drivers/ subdirectory](./drivers/).

Both the MSX Disk BIOS and the MSX Disk Driver reside in the same ROM, located at address 4000H. As mentioned, there is an API each driver must implement so MSX Disk BIOS can interact with the driver. Typically, the MSX Disk is located in the lower section of the page 1, while the driver is placed in the higher section (most drivers adjust their content so the last instruction is closed to 7FFFH).

MSX Disk BIOS does most of the job. Please note that heavy things like the filesystem implementation (FAT12), the operating system boot procedure, the IO device handling, the MSX Disk Basic implementation... all them are implemented in the MSX Disk BIOS. Its size is around 8.7K SLOC. By contrast, the MSX Disk Driver only have to implement the low level operations. That's around 1.9K SLOCs.

## MSX Disk API

The MSX Disk API provides three different set of operations:

- The Disk BIOS calls. This is a table of jumps located at 4010H of the slot where Disk ROM is located.

    04010H DSKIO entrypoint
    04013H DSKCHG entrypoint
    04016H GETDPB entrypoint
    04019H CHOICE entrypoint
    0401CH DSKFMT entrypoint
    0401FH MTOFF entrypoint (only available if 0401FH contains <>0)

- Internal calls for drivers. This is a set of operations that can be used from the driver and are commonly used to implement their low level subroutines.

    ; GETSLT    get my slotid
    ; DIV16     divide
    ; GETWRK    get my workarea
    ; SETINT    install my interrupt handler
    ; PRVINT    call orginal interrupt handler
    ; PROMPT    prompt for phantom drive
    ; RAWFLG    verify flag
    ; $SECBUF   temporary sectorbuffer
    ; XFER      transfer to TPA
    ; DISINT    inform interrupts are being disabled
    ; ENAINT    inform interrupts are being enabled
    ; PROCNM    CALL statement name

- The BDOS system. This is an interface specifically provided for operating systems (MSX-DOS and CP/M), although it can be invoked from MSX-Basic as well. BDOS provides a single subroutine that can respond to multiple operations indicated in the `L` register. It is located in a different address depending on the running environment. For MSX-DOS, it is located at 0005H. For MSX Basic, it is located at F37DH (and the set of operations is limited). You can read the [API reference of BDOS](./bdos.txt) for more details.

## Disk Driver API

The following subroutines are called from MSX Disk BIOS, and must be implemented by any MSX Disk Driver:

    ; INIHRD    initialize diskdriver hardware
    ; DRIVES    how many drives are connected
    ; INIENV    initialize diskdriver workarea
    ; DSKIO     diskdriver sector i/o
    ; DSKCHG    diskdriver diskchange status
    ; GETDPB    build Drive Parameter Block
    ; CHOICE    get format choice string
    ; DSKFMT    format disk
    ; MTOFF     stop diskmotor
    ; OEMSTA    diskdriver special call statements

    ; MYSIZE    size of diskdriver workarea
    ; SECLEN    size of biggest sector supported by the diskdriver
    ; DEFDPB    pointer to a default Drive Parameter Block

You can read the [API refernce for disk drivers](./driver-routines.txt) and the [disk driver template](./drivers/template/driver.mac) for more details.
