:- module(hw5, [catomic_number/2, ion/2, molecule/2]).
:- [catoms].
sum([], 0).
sum([Head|Tail], Total) :- sum(Tail, Kalan), Total is Head + Kalan.

calculate_real_charge(X,RealCharge) :- X =< 4 -> RealCharge is X ; RealCharge is X-8.

last_ele(X,[X]).
last_ele(X,[_|Tail]) :- last_ele(X,Tail).

catomic_number(NAME,CATOMIC_NUMBER) :- catom(NAME, _, _, LST), sum(LST,CATOMIC_NUMBER).

ion(NAME,CHARGE) :- catom(NAME, _, _,LST), last_ele(X,LST),calculate_real_charge(X,CHARGE).


molecule2([],W,TOTAL_CATOMIC_NUMBER,TOTAL_CATOMIC_NUMBER,0,_):-W>=0.
molecule2([Head|Tail], W,CURRENT,TOTAL_CATOMIC_NUMBER,CURRENT_ION,CURRENT_CAT) :- 
    catom(Head, _, _, _), 
    catomic_number(Head,CATOMIC_NUMBER),
    CURRENT_CAT=<CATOMIC_NUMBER,
    W>0,
    ion(Head,ION),
    NEW_ION is ION + CURRENT_ION,
    NEW is CURRENT+CATOMIC_NUMBER,
    NEW=<TOTAL_CATOMIC_NUMBER,
    molecule2(Tail,W-CATOMIC_NUMBER,NEW,TOTAL_CATOMIC_NUMBER,NEW_ION,CATOMIC_NUMBER).

molecule(CATOM_LIST, TOTAL_CATOMIC_NUMBER) :- molecule2(CATOM_LIST,TOTAL_CATOMIC_NUMBER,0,TOTAL_CATOMIC_NUMBER,0,0).
