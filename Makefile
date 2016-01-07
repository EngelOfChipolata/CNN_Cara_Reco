SOURCES = importscans.ml convolutional.ml pooling.ml createnetwork.ml cartoonnetwork.ml debug.ml computevision.ml neteval.ml transform.ml de.ml save.ml learn.ml main.ml
TARGET = CNN
OCAMLC = ocamlc
OCAMLOPT = ocamlopt
DEP = ocamldep
OBJS = $(SOURCES:.ml=.cmx)

all: .depend byte

byte: $(TARGET)

$(TARGET): $(OBJS)
	$(OCAMLOPT) -o $@ $^

%.cmi: %.mli
	$(OCAMLOPT) $<

%.cmx: %.ml
	$(OCAMLOPT) -c $<

.PHONY: clean

clean:
	rm -f *.cm[iox] *~ *.o

.depend: $(SOURCES)
	$(DEP) *.mli *.ml > .depend

include .depend
