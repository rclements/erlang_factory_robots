ERLC_FLAGS=
SOURCES=$(wildcard src/*.erl)
HEADERS=$(wildcard src/*.hrl)
OBJECTS=$(SOURCES:src/%.erl=ebin/%.beam)

shell:
	erl -pa ebin
all: build test
build: $(OBJECTS)
ebin/%.beam : src/%.erl $(HEADERS) Makefile
	erlc $(ERLC_FLAGS) -o ebin/ $<
clean:
	-rm $(OBJECTS)
test: build run_tests
run_tests:
	erl -noshell -pa ebin \
	 -eval 'eunit:test("ebin",[verbose])' \
		-s init stop
