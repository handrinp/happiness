======================================
Z2 Graded Complex Associative Algebras
======================================

This SageMath project is an undertaking to classify the moduli space of low
dimensional Z2 graded complex associative algebras.

Previously, much of this work was done using various versions of Maple
mathematics software.  This project is a rewriting of the original Maple code
into the Sage/Python programming language.  This currently consists of two
phases:

1. Convert all Maple functions verbatim (same names and functionalities).  This will aid in understanding what exactly the code is doing and ease the transition for past researchers.

2. Object orient the SageMath code.  This will most likely require most code to be rewritten from scratch.


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


============================================================================

Sage notebook on the BGSC
=========================

It is currently possible to run a sage notebook server on the BGSC and
access it from a local machine with the following steps.

1. SSH into the BGSC forwarding port 8080 to your local machine:
    ``ssh -L 8080:localhost:8080 USERNAME@bgsc.uwec.edu``

2. Navigate to the SageMath directory on the BGSC:
    ``cd /data/software/sage*``

3. Run Sage:
    ``./sage``

4. Within SageMath, start the notebook server:
    ``notebook(accounts=true)``

5. Open a web browser on your local machine to ``http://localhost:8080``


CoCalc on the BGSC
==================

Eventually it would be nice to permanently host a full fledged CoCalc server
on the BGSC.  This is entirely possible using a CoCalc Docker_ image.
Unfortunately, the installation and setup of this image needs to be done by
a BGSC admin and is not on their list of priorities.




.. _Docker: https://github.com/sagemathinc/cocalc/blob/master/src/dev/docker/README.md
