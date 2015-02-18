;File contains some simple functions to make using eshell less painful, but
;are not important enough to need to be put in their own library.
(defun eshell/emc (filename)
    "Opens a new buffer with filename when emc is typed into eshell"
    (find-file filename)
)
