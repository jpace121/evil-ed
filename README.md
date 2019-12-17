;;; Jimmy's evil emacs config

insert emacs joke here.

THIS IS EXPERIMENTAL AND BLANTANTLY BUGGY.

;; About

Suped up emacs for someone who is a vim guy, but wanted to play with something,
and use something that is really super configureable.

;; Flycheck Needs

Flycheck depends on external tools for checking.

I have:
   Clang for C/C++
   flake8 for python
   chktex
   hunspell

For Irony mode I downloaded (through apt):
    libclang-7-dev
    cmake
    build-essential
    clang-tools-7
    build-essential
and then ran:
    irony-install-server

;; Irony mode for ROS
https://emacs.stackexchange.com/questions/28026/add-include-paths-to-flycheck-and-to-company-irony
```
# create ~/catkin_ws/build/xxx/compile_commands.json
# for all the packages located in ~/catkin_ws/src/xxx
catkin config --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

# in emacs, type:
#     M-x irony-cdb-json-add-compile-commands-path RET
# you will be prompted with the compile_commands.json to add, in this case,
# set the "Project root" to ~/catkin_ws/src/xxx/
# and set the "Compile commands" to ~/catkin_ws/build/xxx/compile_commands.json
emacs src/my_packages/src/foo.cpp
```



