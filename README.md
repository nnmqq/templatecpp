## Template cpp project using build2 as build system

### requires: 
- build2
- clang (optional)
- git
- python
- compiledb

### installing compiledb
> pip install compiledb

### build
**build the whole project**
> b 

**build an specific target**
> b -vn target

build.bat generates compile_commands.json for clangd and outputs it into the root directory
> ./build.bat

In linux process of generating the compilation commands database should be easier 
> b -vn clean update |& compiledb
not tested but should work

### toolchain
By default clang is used as compiler, to autodetect a compiler just remove the file build/config.build
> rm build/config.build

And to set a different compiler
> b configure config.cxx=compiler 

You can also have multiple configurations by invoking the command
> bdep init -C ../project-gcc @gcc cc config.cxx=g++
> bdep init -C ../project-clang @clang cc config.cxx=clang++

For more information about the commands or the build system in general you can checkout the official documentation
[Build2 documentation](https://build2.org/doc.xhtml)