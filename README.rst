======================================
Z2 Graded Complex Associative Algebras
======================================

This SageMath project is an undertaking to classify the moduli space of low
dimensional Z2 graded complex associative algebras.

Previously, much of this work was done using various versions of Maple
mathematics software.  This project is a rewriting of the original Maple code
into the Sage/Python programming language.

============================================================================

Testing
=======

The script ``test_ainfdefs.sage`` is used to test the output of the new Sage
functions against the output of the original Maple functions.  The test script
can be run from a terminal or from within a SageMath session (it's far faster
to run the test script from within Sage).  To execute the test script within
a SageMath session run the following Sage command within the ``~/newdefs/``
folder:

    ``execfile('test_ainfdefs.sage')``


============================================================================

Files
=====

``~/bin/``
----------

``cocalc-connect``
    This script automates connecting and disconnecting to the CoCalc server.
    To interface with the CoCalc server at all, users will first need to add
    thier public keys to the file ``~/.ssh/authorized_keys`` on the CoCalc
    server.  Users will then need to copy this script to their local machines
    and modify the proper script variables (``COCALC_USERNAME`` and
    ``LOCAL_DIR``) before execution.

``~/maple/``
------------

``ainfdefs.txt``
    This is a text file of the original Maple functions.

``~/newdefs/``
--------------

``ainfdefs.sage``
    This file contains all function definitions and global variables.

``test_ainfdefs.sage``
    This script checks the output of the new Sage functions with the expected
    output of the original Maple functions.
