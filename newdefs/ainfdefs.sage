##=============================  ainfdefs.sage  ==============================##
'''
Work in progress; this script is a rewriting of the 'ainfdefs.mws' Maple14
code in the sage/python programming language.

All functions currently mirror the maple14 versions as much as possible.
Function names have been copied verbatim with the exception of:
    maple14  |  sage
    ---------+--------
    sgn         Sgn

NOTE:
The work here is primarily a learning exercise in Maple and Sage.  The final
intention is to fully convert this code to an object oriented system.
Because M. Penkava is already familiar with the Maple named functions and
operations, the intention is for the converted code to follow these
conventions as much as possible possible.

OBJECTS:
A Base is represented by a list.
A Tensor Monomial is represented by a list containing a base and a coefficient.
A Tensor is represented by a list of tensor monomials.
A Coderivation is represented by a list containing a list and an index(number).
'''

##==========================  GLOBAL VARIABLES  ==========================##
# Subject to change for each space tested over (ie. ZEROCOEF is not always 0)
PARITY = 0
DIMENSION = 1
ODD = 1
EVEN = 0
ONE = []
ZEROCOEF = 0
ONECOEF = 1

TMON_BASE = 0  # index of the base in a tensor monomial
TMON_COEF = 1  # index of the coefficient in a tensor monomial

ONETMON = [ONE,ONECOEF]
ZEROTMON = [ONE,ZEROCOEF]

ZEROTENS = []
ONETENS = [ONETMON]

CBASE_LIST = 0   # index of list in a coderivation
CBASE_INDEX = 1  # index of index in a coderivation

##======================  getters and setters  =======================##
# These functions are NOT part of the original Maple code.
# To modify the value of global variables in this module,these functions
# must be used.
def get_DIMENSION():
    return DIMENSION

def set_DIMENSION(dimension):
    global DIMENSION
    DIMENSION = dimension

def get_EVEN():
    return EVEN

def set_EVEN(even):
    global EVEN
    EVEN = even

def get_ODD():
    return ODD

def set_ODD(odd):
    global ODD
    ODD = odd

def get_PARITY():
    return PARITY

def set_PARITY(parity):
    global PARITY
    PARITY = parity


##==========================  basic Functions  ===========================##
# equality tester
def deltaij(i,j):
    return (i == j) + 0

# parity tester
def parity_elem(i):
    if i<=PARITY:
        return 0
    else:
        return 1

# (-1)^i
def Sgn(i):
    ##return 1 if (i & 1) else -1
     return (-1) ** (i % 2)


##=======================  Coefficient Functions  ========================##
# add
def add_coef(a,b):
    return a+b

# convert a number to a coefficient
def mk_num_coef(a):
    return mult_coef_num(ONECOEF,a)

# multipy
def mult_coef(a,b):
    return a*b

# multipy a coefficient by a number
def mult_coef_num(coef,num):
    return coef*num

# simple rule for the parity of a coefficient
def parity_coef(c):
    return 0


##==========================  Basis Functions  ===========================##
# multiply bases for a vector space
def mult_tbas(base1,base2):
    return base1+base2

# parity of basis elements
def parity_tbas(base):
    if base == ONE:
        return 0
    else:
        s = 0
        for t in base:
            s += parity_elem(t)
        return mod(s,2)


##=====================  Tensor Monomial Functions  ======================##
# WTF are there two different functions for right and left multiplication?
# A single function with cases would be cleaner.  (but perhaps slower?)

# degree of a tensor monomial
def degree_tmon(tmon):
    return len(tmon[TMON_BASE])

# The original Maple code for this is incorrect:
# multiply a tensor monimial by a coefficient on the left
def lmult_tmon_coef(coef,tmon):
    return mk_tmon(tmon[TMON_BASE], mult_coef(coef, tmon[TMON_COEF]))

# construct a tensor monimial; base = [ [base], coefficient ]
def mk_tmon(base, coef=ONECOEF):
    if coef == ZEROCOEF:
        return ZEROTMON
    else:
        return [base,coef]

# parity of a tensor monomial
def parity_tmon(tmon):
    return parity_tbas(tmon[TMON_BASE]) + parity_coef(tmon[TMON_COEF]) % 2

# multiply tensor monimial by a coefficient on the right
def rmult_tmon_coef(tmon,coef):
    return mk_tmon(tmon[TMON_BASE],mult_coef(coef,tmon[TMON_COEF]))


##==========================  Tensor Functions  ==========================##
def add_tens(ten1, ten2):
    return ten1 + ten2

# takes in a list of tensor monomials and combines like terms
def comb_tens(tens_list):
    if tens_list == ZEROTENS or tens_list == ZEROTMON:
        return ZEROTENS
    tens_counted = []
    tens_result = ZEROTENS
    for tens in tens_list:
        if tens[TMON_BASE] not in tens_counted:
            tens_counted += [tens[TMON_BASE]]
            coef = ZEROCOEF
            for tens2 in tens_list:
                if tens2[TMON_BASE] == tens[TMON_BASE]:
                    coef = add_coef(tens2[TMON_COEF], coef)
            if coef != ZEROCOEF:
                tens_result = add_tens(tens_result, [[tens[TMON_BASE], coef]])
    return tens_result

# remove all monomials of degree less than or equal cutoff value from a tensor
def cutoff_tens(tens,cutoff):
    tens_result = ZEROTENS
    if tens != ZEROTENS:
        for tmon in tens:
            if degree_tmon(tmon) <= cutoff:
                tens_result = add_tens(tens_result, mk_tens(tmon))
    return tens_result

# multiply a tensor on the left by a coefficient
def lmult_tens_coef(coef,tens):
    if tens == ZEROTENS:
        return ZEROTENS
    res = ZEROTENS
    for i in range(len(tens)):
        res = add_tens(res,mk_tens(lmult_tmon_coef(coef,tens[i])))
    return comb_tens(res)

def mk_tens(tmon):
    return [tmon]

# multiply tensors
def mult_tens(tens1, tens2):
    tens_result = ZEROTENS
    for tmon1 in tens1:
        for tmon2 in tens2:
            tens_result = add_tens(tens_result,
              mk_tens(mk_tmon(mult_tbas(tmon1[TMON_BASE], tmon2[TMON_BASE]),
              mult_coef(tmon1[TMON_COEF], tmon2[TMON_COEF]))))
    return comb_tens(tens_result)

# multipy a tensor by a number
def mult_tens_num(num,tens):
    return rmult_tens_coef(tens,mk_num_coef(num))

# multiply a tensor on the right by a coefficient
def rmult_tens_coef(tens,coef):
    if tens == ZEROTENS:
        return ZEROTENS
    res = ZEROTENS
    for i in range(len(tens)):
        res = add_tens(res,mk_tens(rmult_tmon_coef(tens[i],coef)))
    return comb_tens(res)


##=========================  Printing Functions  =========================##
# print normal coefficient
def pnt_coef(a):
    print(a)
    return a

# pnt_tbase, pnt_tmon, and pnt_tens all simply display their given objects
# using the symbol 'e' along with subscripts to represent basis elements.
# They are not referenced anywhere else in ainfdefs.mws, so for now they have
# been left out of the Sage code.


##=======================  Coderivation Functions  =======================##
def mk_cbase(lst, index):
    cbase_result = [None] * 2
    cbase_result[CBASE_LIST] = lst
    cbase_result[CBASE_INDEX] = index
    return cbase_result

def parity_cbase(cbas):
    return (parity_elem(cbas[CBASE_INDEX]) + parity_tbas(cbas[CBASE_LIST])) % 2

# apply a coderivation base to a tensor base
def apply_cbase_tbas(cbas, tbas):
    if tbas == ONE:
        return ZEROTENS
    res = ZEROTENS
    J = cbas[CBASE_LIST]
    j = cbas[CBASE_INDEX]
    otbas = []
    for k in range(len(tbas)-len(J)+1):
        if k > 0:
            coef = deltaij(J,tbas[k:k+len(J)]) * Sgn(parity_tbas(tbas[0:k-1]) *
                parity_cbase(cbas))
            otbas = tbas[0:k-1]
        else:
            coef = deltaij(J,tbas[k:k+len(J)]) * Sgn(parity_tbas(tbas) *
                parity_cbase(cbas))
            otbas = []
        otbas = otbas + [j] + tbas[k+len(J):len(tbas)-1]
        res = add_tens(res,mk_tens(mk_tmon(otbas,coef)))
    return comb_tens(res)

# apply a coderivation base to a tensor monomial
def apply_cbase_tmon(cbas, tmon):
    return rmult_tens_coef(apply_cbase_tbas(cbas, tmon[TMON_BASE]),
        tmon[TMON_COEF])

#


