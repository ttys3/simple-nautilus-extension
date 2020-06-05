TARGET=nautilus_ext.so
OBJECTS=plugin.o

LIBDIR=/usr/lib64
WFLAGS=-Wall -pedantic -Wmissing-prototypes
CFLAGS= $(WFLAGS) -fPIC -g \
	$(shell pkg-config --cflags libnautilus-extension)

LDFLAGS=-shared \
	$(shell pkg-config --libs libnautilus-extension)

all: $(TARGET)

$(TARGET): $(OBJECTS)
		gcc $(LDFLAGS) $(OBJECTS) -o $(TARGET)

# /usr/lib64/nautilus/extensions-3.0
install: all
	test -d $(LIBDIR)/nautilus/extensions-3.0 || sudo mkdir -p $(LIBDIR)/nautilus/extensions-3.0
	sudo cp $(TARGET) $(LIBDIR)/nautilus/extensions-3.0/

run:
	-killall nautilus
	/usr/bin/nautilus --gapplication-service

plugin.o: plugin.c
	gcc -c $(CFLAGS) plugin.c -o plugin.o

clean:
	rm -f $(OBJECTS) $(TARGET)
