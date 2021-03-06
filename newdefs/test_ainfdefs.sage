#!/usr/bin/env sage

import os
##===========================  test_ainfdefs.sage  ===========================##
# This script tests the functions in `ainfdefs.sage` against the expected
# return values from the original Maple code.

# set up testing environment by parsing ainfdefs into regular python
os.system('sage --preparse ainfdefs.sage')
os.system('mv ainfdefs.sage.py ainfdefs.py')
from ainfdefs import *

print "Testing ainfdefs.sage..."


##============================  Basic tests  =============================##
def caseDeltaij():
    assert (deltaij(1,1) == 1), \
        "deltaij(1,1) should be 1"
    assert (deltaij(1,-2) == 0), \
        "deltaij(1,-2) should be 0"

def caseParityElem():
    assert (parity_elem(22) == 1), \
        "parity_elem(22) should be 1"
    assert (parity_elem(-5) == 0), \
        "parity_elem(-5) should be 0"

def caseSgn():
    assert (Sgn(4) == 1), \
        "Sgn(4) should be 1"
    assert (Sgn(5) == -1), \
        "Sgn(5) should be -1"


##==========================  Coefficient tests  =========================##
def caseAddCoef():
    assert (add_coef(2,5) == 7), \
        "add_coef(2,5) should be 7"
    assert (add_coef(0,-3) == -3), \
        "add_coef(0,-3) should be -3"

def caseMkNumCoef():
    assert(mk_num_coef(3) == mult_coef_num(ONECOEF,3)), \
        "mk_num_coef(3) should be mult_coef_num(ONECOEF,3)"

def caseMultCoef():
    assert (mult_coef(1,4) == 4), \
        "mult_coef(1,4) should be 4"
    assert (mult_coef(2,-3) == -6), \
        "mult_coef(2,-3) should be -6"

def caseMultCoefNum():
    assert (mult_coef_num(2,4) == 8), \
        "mult_coef_num(2,4) should be 8"
    assert (mult_coef_num(9,0) == 0), \
        "mult_coef_num(9,0) should be 0"

def caseParityCoef():
    assert(parity_coef(3) == 0), \
        "parity_coef(3) should be 0"


##============================  Basis tests  =============================##
def caseMultTbas():
    assert (mult_tbas([1,2,3],[7,8,9]) == [1,2,3,7,8,9]), \
        "mult_tbas([1,2,3],[7,8,9]) should be [1,2,3,7,8,9]"
    assert (mult_tbas([],[0]) == [0]), \
        "mult_tbas([],[0]) should be [0]"

def caseParityTbas():
    assert (parity_tbas(ONE) == 0), \
        "parity_tbas(ONE) should be 0"
    assert (parity_tbas([1,2,3]) == 1), \
        "parity_tbas([1,2,3]) should be 1"
    assert (parity_tbas([1,2]) == 0), \
        "parity_tbas([1,2]) should be 0"


##=======================  Tensor Monomial tests  ========================##
def caseDegreeTmon():
    assert(degree_tmon([[1,2],2]) == 2), \
        "degree_tmon([[1,2],2]) should be 2"
    assert(degree_tmon([[1,2,3,4],5]) == 4), \
        "degree_tmon([[1,2,3,4],5]) should be 4"

def caseLmultTmonCoef():
    assert(lmult_tmon_coef(2,[[1,2,3],1]) == [[1,2,3],2]), \
        "lmult_tmon_coef(2,[[1,2,3],1]) should be [[1,2,3],2]"
    assert(lmult_tmon_coef(3,[[1,2],4]) == [[1,2],12]), \
        "lmult_tmon_coef(3,[[1,2],4]) should be [[1,2],12]"

def caseMkTmon():
    assert(mk_tmon([1,2,3]) == [[1, 2, 3], 1]), \
        "mk_tmon([1,2,3]) should be [[1, 2, 3], 1]"
    assert(mk_tmon([1,2,3],4) == [[1, 2, 3], 4]), \
        "mk_tmon([1,2,3],4) should be [[1, 2, 3], 4]"
    assert(mk_tmon([1,2],0) == [[], 0]), \
        "mk_tmon([1,2],0) should be [[], 0]"

def caseParityTmon():
    assert(parity_tmon([[1,2,3],2]) == 1), \
        "parity_tmon([[1,2,3],2]) should be 1"
    assert(parity_tmon([[1,2],1]) == 0), \
        "parity_tmon([[1,2],1]) should be 0"

def caseRmultTmonCoef():
    assert(rmult_tmon_coef([[1,2,3],1],2) == [[1,2,3],2]), \
        "rmult_tmon_coef([[1,2,3],1],2) should be [[1,2,3],2]"
    assert(rmult_tmon_coef([[1,2],4],3) == [[1,2],12]), \
        "rmult_tmon_coef([[1,2],4],3) should be [[1,2],12]"


##============================  Tensor tests  ============================##
def caseAddTens():
    assert(add_tens([[[1,2],7]],[[[3,4],2]]) == [[[1,2],7],[[3,4],2]]), \
        "add_tens([[[1,2],7]], [[[3,4],2]]) should be [[[1,2],7],[[3,4],2]])"

def caseCombTens():
    assert(comb_tens([[[1,2,3],6]]) == [[[1,2,3],6]]), \
        "comb_tens([[[1,2,3],6]]) should be [[[1,2,3],6]]"
    assert(comb_tens([[[1,2],2],[[2,3],5],[[1,2],4]]) == [[[1,2],6],[[2,3],5]]), \
        "comb_tens([[[1,2],2],[[2,3],5],[[1,2],4]]) is incorrect"
    assert(comb_tens([[[1,3],2],[[],0]]) == [[[1,3],2]]), \
        "comb_tens([[[1,3],2],[[],0]]) should be [[[1,3],2]]"

def caseCutoffTens():
    assert(cutoff_tens(ZEROTENS,666) == ZEROTENS), \
        "cutoff_tens(ZEROTENS,666) should be ZEROTENS"
    assert(cutoff_tens([[[1,2],3],[[1,2,3],4]],2) == [[[1,2],3]]), \
        "cuttoff_tens([[[1,2],3],[[1,2,3],4]],2) should be [[[1,2],3]]"

def caseLmultTensCoef():
    assert(lmult_tens_coef(7,[[[1,2],5]]) == [[[1,2],35]]), \
        "lmult_tens_coef(7,[[[1,2],5]]) should be [[[1,2],35]]"
    assert(lmult_tens_coef(3,[[[1,2],2],[[1,3],3]]) == [[[1,2],6],[[1,3],9]]), \
        "lmult_tens_coef(3,[[[1,2],2],[[1,3],3]]) is incorrect"

def caseMkTens():
    assert(mk_tens([[1,2],3]) == [[[1,2],3]]), \
        "mk_tens([[1,2],3]) should be [[[1,2],3]]"

def caseMultTens():
    assert(mult_tens([[[1,2],3]],[[[4,5],6]]) == [[[1,2,4,5],18]]), \
        "mult_tens([[[1,2],3]],[[[4,5],6]]) should be [[[1,2,4,5],18]]"
    assert(mult_tens([[[1,2],3],[[3,4],5]],[[[4,5],6],[[7,9],11]]) ==
        [[[1,2,4,5],18],[[1,2,7,9],33],[[3,4,4,5],30],[[3,4,7,9],55]]), \
        "mult_tens([[[1,2],3],[[3,4],5]],[[[4,5],6],[[7,9],11]] is incorrect"

def caseMultTensNum():
    assert(mult_tens_num(3,[[[1,2],7]]) == [[[1,2],21]]), \
        "mult_tens_num(3,[[[1,2],7]]) should be [[[1,2],21]]"
    assert(mult_tens_num(3,[[[1,2],7],[[1,3],3]]) == [[[1,2],21],[[1,3],9]]), \
        "mult_tens_num(3,[[[1,2],7],[[1,3],3]]) is incorrect"

def caseRmultTensCoef():
    assert(rmult_tens_coef([[[1,3],2]],7) == [[[1,3],14]]), \
        "rmult_tens_coef([[[1,3],2]],7) should be [[[1,3],14]]"
    assert(rmult_tens_coef([[[1,2],3],[[1,3],4]],2) == [[[1,2],6],[[1,3],8]]) ,\
        "rmult_tens_coef([[[1,2],3],[[1,3],4]],2) is incorrect"


##===========================  Printing Tests  ===========================##
def casePntCoef():
    assert(pnt_coef(42) == 42), \
        "pnt_coef(42) should be 42"


##=========================  Coderivation Tests  =========================##
def caseMkCbase():
    assert(mk_cbase([1,2,3],4) == [[1,2,3],4]), \
        "mk_cbase([1,2,3],4]) should be [[1,2,3],4]"

def caseParityCbase():
    assert(parity_cbase([[1,2,3],4]) == 0), \
        "parity_cbase([[1,2,3],4]) should be 0 (when PARITY=0)"
    set_PARITY(2)
    assert(parity_cbase([[1,2,3],2]) == 1), \
        "parity_cbase([[1,2,3],2]) should be 1 (when PARITY=2)"
    set_PARITY(0)

def caseApplyCbaseTbas():
    assert(apply_cbase_tbas([[1,2,3],4],[1,2,3]) == [[[4],1]]), \
        "apply_cbase_tbas([[1,2,3],4],[1,2,3]) should be [[[4],1]]"
    assert(apply_cbase_tbas([[1,2,3],7],[4,5,6]) == ZEROTENS), \
        "apply_cbase_tbas([[1,2,3],7],[4,5,6]) should be ZEROTENS"

def caseApplyCbaseTmon():
    assert(apply_cbase_tmon([[1,2,3],4],[[1,2,3],5]) == [[[4],5]]), \
        "apply_cbase_tmon([[1,2,3],4],[1,2,3],4]) should be [[[4],5]]"
    assert(apply_cbase_tmon([[1,2],3],[[1,3],4]) == ZEROTENS), \
        "apply_cbase_tmon([[1,2],3],[[1,3],4]) should be ZEROTENS)"


##============================  Test Suites  =============================##
# This is where you assemble groups of test cases to be run
# Each test suite contains 1 or more test cases - there may a setup or
# tear-down in between

def suiteInitialTests():
    caseDeltaij()
    caseParityElem()
    caseSgn()

def suiteCoefficientTests():
    caseAddCoef()
    caseMkNumCoef()
    caseMultCoef()
    caseMultCoefNum()
    caseParityCoef()

def suiteBasisTests():
    caseMultTbas()
    caseParityTbas()

def suiteTensorMonomialTests():
    caseDegreeTmon()
    caseLmultTmonCoef()
    caseMkTmon()
    caseParityTmon()
    caseRmultTmonCoef()

def suiteTensorTests():
    caseAddTens()
    caseCombTens()
    caseCutoffTens()
    caseLmultTensCoef()
    caseMkTens()
    caseMultTens()
    caseMultTensNum()
    caseRmultTensCoef()

def suitePrintingTests():
    casePntCoef()

def suiteCoderivationTests():
    caseMkCbase()
    caseParityCbase()
    caseApplyCbaseTbas()
    caseApplyCbaseTmon()


##============================  Test Runner  =============================##
# This is where the tests are actually run
# Run the test suites in the try body below

try:
    # Test suites go here!
    suiteInitialTests()
    suiteCoefficientTests()
    suiteBasisTests()
    suiteTensorMonomialTests()
    suiteTensorTests()
    suitePrintingTests()
    suiteCoderivationTests()

    # Tests all pass :)
    print "High five! All tests pass!"
except AssertionError as err:
    # Some test failed :(
    print err

# tear down testing environment
os.system('rm -f ainfdefs.py ainfdefs.pyc test_ainfdefs.sage.py')


