#
# A simple Makefile
#
######

ATSCC=$(ATSHOME)/bin/atscc
ATSOPT=$(ATSHOME)/bin/atsopt

######

ATSRUNTIME=$(ATSHOME)/ccomp/runtime

######
#
LDPATH :=
LDPATH += -L$(PATSHOME)/utils/libatsopt
#
######

LIBGMP=
LIBGMP=-lgmp

######
#
patsopt: \
patsopt.dats; $(ATSCC) -o $@ $< $(LDPATH) -latsopt -lats $(LIBGMP)
#
######

patsopt_ccomp: \
patsopt_ccomp.dats; $(ATSCC) -o $@ $< $(LDPATH) -latsopt -lats $(LIBGMP)

######

patsopt_atscc2js: \
patsopt_atscc2js.dats; $(ATSCC) -o $@ $< $(LDPATH) -latsopt -lats $(LIBGMP)

######

clean:: ; rm -f *~
clean:: ; rm -f *_?ats.o
clean:: ; rm -f *_?ats.c

######

cleanall:: clean
cleanall:: ; rm -f patsopt
cleanall:: ; rm -f patsopt_ccomp
cleanall:: ; rm -f patsopt_atscc2js

###### end of [Makefile] ######
