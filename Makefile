CC=gcc
CFLAGS=-g -Wall -O0
OBJS=cache_simulator.o cache.o
TARGET=cache_simulator

$(TARGET): $(OBJS)
	$(CC) -o $@ $(OBJS)

clean:
	rm -rf $(OBJS) $(TARGET)

test: $(TARGET) test_simple test_milc test_gcc test_libquantum

test_simple: $(TARGET)
	@echo "Testing simple"; \
        ./$(TARGET) -c 1024:8:8 -x sample_input/simple | diff -Naur sample_output/simple - ;\
        if [ $$? -eq 0 ]; then echo "\tTest seems correct\n"; else echo "\tResults not identical, check the diff output\n"; fi


test_milc: $(TARGET)
	@echo "Testing milc"; \
        ./$(TARGET) -c 1024:8:8 -x sample_input/milc | diff -Naur sample_output/milc - ;\
        if [ $$? -eq 0 ]; then echo "\tTest seems correct\n"; else echo "\tResults not identical, check the diff output\n"; fi
	

test_gcc: $(TARGET)
	@echo "Testing gcc"; \
        ./$(TARGET) -c 1024:8:8 -x sample_input/gcc | diff -Naur sample_output/gcc - ;\
        if [ $$? -eq 0 ]; then echo "\tTest seems correct\n"; else echo "\tResults not identical, check the diff output\n"; fi
	

test_libquantum: $(TARGET)
	@echo "Testing libquantum"; \
        ./$(TARGET) -c 1024:8:8 -x sample_input/libquantum | diff -Naur sample_output/libquantum - ;\
        if [ $$? -eq 0 ]; then echo "\tTest seems correct\n"; else echo "\tResults not identical, check the diff output\n"; fi
	
