# MSX System 1.0

This directory contains the source code of the MSX System version 1.0.

## Dependencies

### Pasmo assembler

The code was adapted to be assembled by [Pasmo](http://pasmo.speccy.org/). However, it only works in version `v0.6.0-20070113.0`. Previous versions do not implement the macros used here correctly, and they will fail to assembly the code. 

To complicate the things even more, you might find some problems compiling Pasmo v0.6 from the source tarball in some systems. You may find an error indicating `for_each()` function is not found (confirmed in Ubuntu Linux with both GCC and CLang). The cause of this is that the header where `std::for_each` is declared is not included in the `modules.cpp` file. You can fix it by ensuring:

- Including `<algorithm>` at the beginning of the file.
- Adding the clause `using std::for_each;` after includes block.

The top of the file should be similar to:

```cpp
// module.cpp
// Revision 10-oct-2006


#include "module.h"

#include "trace.h"

#include <algorithm>
#include <fstream>
#include <stdexcept>

using std::ifstream;
using std::endl;
using std::runtime_error;
using std::logic_error;
using std::pair;
using std::make_pair;
using std::for_each;


namespace pasmo {
namespace impl {
```

With this, Pasmo v0.6 should compile successfully.

### Hexyl (optional)

The build chain uses Hexyl to generate an hexadecimal representation of the ROM image. This is optional, but useful for debugging. 

The best choice to install Hexyl is `apt-get install hexyl` if you are using a Linux distribution that ships the package. If not, it is also available in Homebrew with `brew install hexyl`. 

## Build

If you want to generate the ROM files for MSX System in every supported region, you can run:

```
make rom
```

This will assemble the source code one time per each supported region, and will save the output ROM in the `target/` directory. A symbol file with `.symbol` extension will be also generated. This contains a list of all symbols defined during the assembly, and their memory locations.

If you also want to generate an hex dump of the ROM images, you can run:

```
make hex
```

This will put a file with `.hex` extension in `target/` for each ROM image file. 
